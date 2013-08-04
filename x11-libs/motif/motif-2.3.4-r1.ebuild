# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/motif/motif-2.3.4-r1.ebuild,v 1.23 2013/08/04 18:36:09 ago Exp $

EAPI=5

inherit autotools eutils flag-o-matic multilib multilib-minimal

DESCRIPTION="The Motif user interface component toolkit"
HOMEPAGE="http://sourceforge.net/projects/motif/
	http://motif.ics.com/"
SRC_URI="mirror://sourceforge/project/motif/Motif%20${PV}%20Source%20Code/${P}-src.tgz
	mirror://gentoo/${P}-patches-1.tar.xz"

LICENSE="LGPL-2.1+ MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc ~x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="examples jpeg +motif22-compatibility png static-libs unicode xft"

RDEPEND="abi_x86_32? ( !app-emulation/emul-linux-x86-motif[-abi_x86_32(-)] )
	|| ( (
		x11-libs/libX11[${MULTILIB_USEDEP}]
		x11-libs/libXext[${MULTILIB_USEDEP}]
		x11-libs/libXmu[${MULTILIB_USEDEP}]
		x11-libs/libXp[${MULTILIB_USEDEP}]
		x11-libs/libXt[${MULTILIB_USEDEP}]
		xft? (
			media-libs/fontconfig[${MULTILIB_USEDEP}]
			x11-libs/libXft[${MULTILIB_USEDEP}]
		)
	)
	(
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXmu
		x11-libs/libXp
		x11-libs/libXt
		xft? ( media-libs/fontconfig x11-libs/libXft )
		abi_x86_32? ( amd64? ( app-emulation/emul-linux-x86-xlibs ) )
	) )
	|| ( (
		unicode? ( virtual/libiconv[${MULTILIB_USEDEP}] )
		jpeg? ( virtual/jpeg:0=[${MULTILIB_USEDEP}] )
		png? ( >=media-libs/libpng-1.4:0=[${MULTILIB_USEDEP}] )
	)
	(
		unicode? ( virtual/libiconv )
		jpeg? ( virtual/jpeg:0= )
		png? ( >=media-libs/libpng-1.4:0= )
		abi_x86_32? ( amd64? (
			jpeg? ( app-emulation/emul-linux-x86-baselibs )
			png? ( app-emulation/emul-linux-x86-baselibs )
		) )
	) )"

DEPEND="${RDEPEND}
	sys-devel/flex
	|| ( dev-util/byacc sys-freebsd/freebsd-ubin )
	x11-misc/xbitmaps"

src_prepare() {
	EPATCH_SUFFIX=patch epatch
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
	[[ ${CHOST} == *-solaris2.11 ]] \
		&& append-cppflags -DNEED_XOS_R_H -DHAVE_READDIR_R_3

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
