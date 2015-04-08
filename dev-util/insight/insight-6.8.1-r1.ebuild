# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/insight/insight-6.8.1-r1.ebuild,v 1.3 2015/03/25 13:26:47 jlec Exp $

EAPI=4

inherit eutils autotools versionator

MY_P="${PN}-$(replace_version_separator 2 -)"

DESCRIPTION="A graphical interface to the GNU debugger"
HOMEPAGE="http://sourceware.org/insight/"
SRC_URI="ftp://sources.redhat.com/pub/${PN}/releases/${MY_P}a.tar.bz2
	http://dev.gentoo.org/~xarthisius/distfiles/${P}-patchset-02.tar.xz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND="
	dev-libs/expat
	dev-tcltk/iwidgets
	sys-libs/ncurses
	sys-libs/readline
	x11-libs/libX11
"
DEPEND="${RDEPEND}
	dev-lang/tcl:0
	dev-lang/tk:0
	dev-tcltk/itcl
	dev-tcltk/itk
	sys-devel/bison
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	local location

	EPATCH_FORCE="yes" \
	EPATCH_SOURCE="${WORKDIR}/patches" \
	EPATCH_SUFFIX="patch" \
	epatch

	epatch "${FILESDIR}"/${P}-automake-1.13.patch

	# remove bundled stuff
	rm -rf "${S}"/{itcl,tcl,tk,readline} || die

	for location in gdb/gdbtk/plugins libgui; do
		pushd ${location} > /dev/null
		eautoreconf
		popd > /dev/null
	done

	cd gdb
	eautoconf

	sed -i \
		-e 's:tk.h:tkInt.h:g' \
		-e 's:ITCL_BUILD_LIB_SPEC:ITCL_LIB_SPEC:g' \
		-e 's:ITK_BUILD_LIB_SPEC:ITK_LIB_SPEC:g' \
		"${S}/gdb/configure" || die
}

src_configure() {
	export ac_cv_c_itclh="${EPREFIX}/usr/include/"
	export ac_cv_c_itkh="${EPREFIX}/usr/include/"

	. "${EPREFIX}/usr/$(get_libdir)/tclConfig.sh"
	. "${EPREFIX}/usr/$(get_libdir)/tkConfig.sh"
	. "${EPREFIX}/usr/$(get_libdir)/itclConfig.sh"

	# there will be warning about undefined options
	# because it is passed only to some subdir configures
	econf \
		--disable-static \
		--with-system-readline \
		--disable-rpath \
		--disable-werror \
		$(use_enable nls) \
		--enable-gdbtk \
		--enable-sim \
		--with-expat \
		--datadir=/usr/share \
		--with-tclinclude="${TCL_SRC_DIR}" \
		--with-tkinclude="${TK_SRC_DIR}"
}

src_install() {
	# the tcl-related subdirs are not parallel safe
	emake -j1 DESTDIR="${D}" install

	find "${ED}" -name '*.la' -exec rm -f {} +

	dodoc gdb/gdbtk/{README,TODO}

	# scrub all the cruft we dont want
	rm -f "${ED}"/usr/bin/{gdb,gdbtui,gdbserver} || die
	rm -f "${ED}"/usr/$(get_libdir)/*.a || die
	rm -f "${ED}"/usr/$(get_libdir)/*.sh || die
	rm -rf "${ED}"/usr/include || die
	rm -rf "${ED}"/usr/man || die
	rm -rf "${ED}"/usr/share/{man,info,locale} || die

	# regen pkgIndex.tcl
	echo "pkg_mkIndex \"${ED}/usr/share/${PN}/gui\"" | tclsh
}
