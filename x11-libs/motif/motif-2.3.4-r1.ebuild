# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/motif/motif-2.3.4-r1.ebuild,v 1.2 2013/03/16 17:58:06 ulm Exp $

EAPI=5

inherit autotools eutils flag-o-matic multilib multilib-minimal

DESCRIPTION="The Motif user interface component toolkit"
HOMEPAGE="http://sourceforge.net/projects/motif/
	http://motif.ics.com/"
SRC_URI="mirror://sourceforge/project/motif/Motif%20${PV}%20Source%20Code/${P}-src.tgz"

LICENSE="LGPL-2.1+ MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="examples jpeg +motif22-compatibility png static-libs unicode xft"

RDEPEND="x11-libs/libXmu[${MULTILIB_USEDEP}]
	x11-libs/libXp[${MULTILIB_USEDEP}]
	unicode? ( virtual/libiconv )
	xft? ( x11-libs/libXft[${MULTILIB_USEDEP}] )
	jpeg? ( virtual/jpeg )
	png? ( >=media-libs/libpng-1.4 )
	abi_x86_32? (
		amd64? ( app-emulation/emul-linux-x86-baselibs )
		!app-emulation/emul-linux-x86-motif
	)"

DEPEND="${RDEPEND}
	sys-devel/flex
	|| ( dev-util/byacc sys-freebsd/freebsd-ubin )
	x11-misc/xbitmaps"

src_prepare() {
	epatch "${FILESDIR}/${P}-solaris.patch"
	epatch "${FILESDIR}/${PN}-2.3.2-sanitise-paths.patch"
	epatch "${FILESDIR}/${P}-parallel-make.patch"
	epatch "${FILESDIR}/${P}-install-dirs.patch"
	[[ ${CHOST} == *-solaris2.11 ]] \
		&& epatch "${FILESDIR}/${PN}-2.3.2-solaris-2.11.patch"

	epatch_user

	# disable compilation of demo binaries
	sed -i -e '/^SUBDIRS/{:x;/\\$/{N;bx;};s/[ \t\n\\]*demos//;}' Makefile.am

	# add X.Org vendor string to aliases for virtual bindings
	echo -e '"The X.Org Foundation"\t\t\t\t\tpc' >>bindings/xmbind.alias

	AT_M4DIR=. eautoreconf

	# get around some LANG problems in make (#15119)
	LANG=C

	# bug #80421
	filter-flags -ftracer

	# feel free to fix properly if you care
	append-flags -fno-strict-aliasing

	# For Solaris Xos_r.h :(
	[[ ${CHOST} == *-solaris2.11 ]] && append-flags -DNEED_XOS_R_H=1

	if use !elibc_glibc && use !elibc_uclibc && use unicode; then
		# libiconv detection in configure script doesn't always work
		# http://bugs.motifzone.net/show_bug.cgi?id=1423
		export LIBS="${LIBS} -liconv"
	fi

	# "bison -y" causes runtime crashes #355795
	export YACC=byacc
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
		--with-x \
		$(use_enable static-libs static) \
		$(use_enable motif22-compatibility) \
		$(use_enable unicode utf8) \
		$(use_enable xft) \
		$(use_enable jpeg) \
		$(use_enable png)
}

src_compile() {
	local native_dir

	# Motif has build-time tools in the tools/wml subdirectory that
	# cannot be built for other ABIs because of missing external libs.
	# So we build the native ABI first, and then replace the tools
	# directory in other ABIs by the native one.

	my_best_abi_compile() {
		native_dir="${BUILD_DIR}"
		emake -C "${BUILD_DIR}"
	}
	multilib_for_best_abi my_best_abi_compile

	my_other_abi_compile() {
		[[ ${BUILD_DIR} = "${native_dir}" ]] && return
		rm -rf "${BUILD_DIR}"/tools
		ln -s "${native_dir}"/tools "${BUILD_DIR}"/ || die
		emake -C "${BUILD_DIR}"
	}
	multilib_foreach_abi my_other_abi_compile
}

multilib_src_install_all() {
	# mwm default configs
	insinto /usr/share/X11/app-defaults
	newins "${FILESDIR}"/Mwm.defaults Mwm

	if use examples; then
		my_install_demos() {
			emake -C "${BUILD_DIR}"/demos DESTDIR="${D}" install-data
		}
		multilib_for_best_abi my_install_demos
		dodir /usr/share/doc/${PF}/demos
		mv "${ED}"/usr/share/Xm/* "${ED}"/usr/share/doc/${PF}/demos || die
	fi
	rm -rf "${ED}"/usr/share/Xm

	prune_libtool_files

	dodoc BUGREPORT ChangeLog README RELEASE RELNOTES TODO
}
