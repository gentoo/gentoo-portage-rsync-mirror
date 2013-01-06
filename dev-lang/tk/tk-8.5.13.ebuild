# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tk/tk-8.5.13.ebuild,v 1.3 2012/12/05 08:51:37 ulm Exp $

EAPI=4

inherit autotools eutils multilib toolchain-funcs prefix
inherit autotools eutils multilib prefix toolchain-funcs virtualx

MY_P="${PN}${PV/_beta/b}"

DESCRIPTION="Tk Widget Set"
HOMEPAGE="http://www.tcl.tk/"
SRC_URI="mirror://sourceforge/tcl/${MY_P}-src.tar.gz"

LICENSE="tcltk"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="debug threads truetype aqua xscreensaver"

RDEPEND="
	!aqua? (
		media-libs/fontconfig
		x11-libs/libX11
		x11-libs/libXt
		truetype? ( x11-libs/libXft )
		xscreensaver? ( x11-libs/libXScrnSaver )
	)
	~dev-lang/tcl-${PV}"
DEPEND="${RDEPEND}
	!aqua? ( x11-proto/xproto )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	tc-export CC

	epatch \
		"${FILESDIR}"/${PN}-8.5.11-fedora-xft.patch \
		"${FILESDIR}"/${P}-multilib.patch

	epatch "${FILESDIR}"/${PN}-8.4.15-aqua.patch
	eprefixify unix/Makefile.in

	# Bug 125971
	epatch "${FILESDIR}"/${PN}-8.5.10-conf.patch

	# Bug 354067 : the same applies to tk, since the patch is about tcl.m4, just
	# copy the tcl patch
	epatch "${FILESDIR}"/tcl-8.5.9-gentoo-fbsd.patch

	# Make sure we use the right pkg-config, and link against fontconfig
	# (since the code base uses Fc* functions).
	sed \
		-e 's/FT_New_Face/XftFontOpen/g' \
		-e "s:\<pkg-config\>:$(tc-getPKG_CONFIG):" \
		-e 's:xft freetype2:xft freetype2 fontconfig:' \
		-i unix/configure.in || die
	rm -f unix/configure || die

	cd "${S}"/unix
	eautoreconf
}

src_configure() {
	cd "${S}"/unix

	local mylibdir=$(get_libdir)

	econf \
		--with-tcl="${EPREFIX}/usr/${mylibdir}" \
		$(use_enable threads) \
		$(use_enable aqua) \
		$(use_enable truetype xft) \
		$(use_enable xscreensaver xss) \
		$(use_enable debug symbols)
}

src_compile() {
	cd "${S}"/unix && emake
}

src_test() {
	cd "${S}"/unix && Xemake test
}

src_install() {
	#short version number
	local v1
	v1=${PV%.*}

	cd "${S}"/unix
	S= emake DESTDIR="${D}" install

	# normalize $S path, bug #280766 (pkgcore)
	local nS="$(cd "${S}"; pwd)"

	# fix the tkConfig.sh to eliminate refs to the build directory
	local mylibdir=$(get_libdir); mylibdir=${mylibdir//\/}
	sed -i \
		-e "s,^TK_BUILD_LIB_SPEC='-L.*/unix ,TK_BUILD_LIB_SPEC='," \
		-e "s,^TK_SRC_DIR='.*',TK_SRC_DIR='${EPREFIX}/usr/${mylibdir}/tk${v1}/include'," \
		-e "s,^TK_BUILD_STUB_LIB_SPEC='-L.*/unix ,TK_BUILD_STUB_LIB_SPEC='," \
		-e "s,^TK_BUILD_STUB_LIB_PATH='.*/unix,TK_BUILD_STUB_LIB_PATH='${EPREFIX}/usr/${mylibdir}," \
		-e "s,^TK_LIB_FILE='libtk${v1}..TK_DBGX..so',TK_LIB_FILE=\"libtk${v1}\$\{TK_DBGX\}.so\"," \
		-e "s,^TK_STUB_LIB_SPEC='-L${EPREFIX}/usr/${mylibdir} ,TK_STUB_LIB_SPEC='," \
		-e "s,^TK_LIB_SPEC='-L${EPREFIX}/usr/${mylibdir} ,TK_LIB_SPEC='," \
		"${ED}"/usr/${mylibdir}/tkConfig.sh || die
	if [[ ${CHOST} != *-darwin* && ${CHOST} != *-mint* ]] ; then
		sed -i \
				-e "s,^\(TK_CC_SEARCH_FLAGS='.*\)',\1:${EPREFIX}/usr/${mylibdir}'," \
				-e "s,^\(TK_LD_SEARCH_FLAGS='.*\)',\1:${EPREFIX}/usr/${mylibdir}'," \
				"${ED}"/usr/${mylibdir}/tkConfig.sh || die
	fi

	# install private headers
	insinto /usr/${mylibdir}/tk${v1}/include/unix
	doins "${S}"/unix/*.h
	insinto /usr/${mylibdir}/tk${v1}/include/generic
	doins "${S}"/generic/*.h
	rm -f "${ED}"/usr/${mylibdir}/tk${v1}/include/generic/tk.h
	rm -f "${ED}"/usr/${mylibdir}/tk${v1}/include/generic/tkDecls.h
	rm -f "${ED}"/usr/${mylibdir}/tk${v1}/include/generic/tkPlatDecls.h

	# install symlink for libraries
	#dosym libtk${v1}.a /usr/${mylibdir}/libtk.a
	dosym libtk${v1}$(get_libname) /usr/${mylibdir}/libtk$(get_libname)
	dosym libtkstub${v1}.a /usr/${mylibdir}/libtkstub.a

	dosym wish${v1} /usr/bin/wish

	cd "${S}"
	dodoc ChangeLog* README changes
}
