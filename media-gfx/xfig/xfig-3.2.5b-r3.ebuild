# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xfig/xfig-3.2.5b-r3.ebuild,v 1.6 2013/06/26 02:55:48 ago Exp $

EAPI=5

inherit eutils multilib

MY_P=${PN}.${PV}

DESCRIPTION="A menu-driven tool to draw and manipulate objects interactively in an X window."
HOMEPAGE="http://www.xfig.org"
SRC_URI="mirror://sourceforge/mcj/${MY_P}.full.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="nls"

RDEPEND="x11-libs/libXaw
		x11-libs/libXp
		x11-libs/libXaw3d
		nls? ( x11-libs/libXaw3d[unicode] )
		x11-libs/libXi
		x11-libs/libXt
		virtual/jpeg
		media-libs/libpng
		media-fonts/font-misc-misc
		media-fonts/urw-fonts
		>=media-gfx/transfig-3.2.5-r1
		media-libs/netpbm"
DEPEND="${RDEPEND}
		x11-misc/imake
		x11-proto/xproto
		x11-proto/inputproto"

S=${WORKDIR}/${MY_P}

sed_Imakefile() {
	# see Imakefile for details
	vars2subs=( BINDIR="${EPREFIX}"/usr/bin
		PNGINC=-I"${EPREFIX}"/usr/include
		JPEGLIBDIR="${EPREFIX}"/usr/$(get_libdir)
		JPEGINC=-I"${EPREFIX}"/usr/include
		XPMLIBDIR="${EPREFIX}"/usr/$(get_libdir)
		XPMINC=-I"${EPREFIX}"/usr/include/X11
		USEINLINE=-DUSE_INLINE
		XFIGLIBDIR="${EPREFIX}"/usr/share/xfig
		XFIGDOCDIR="${EPREFIX}/usr/share/doc/${PF}"
		MANDIR="${EPREFIX}/usr/share/man/man\$\(MANSUFFIX\)"
		"CC=$(tc-getCC)" )

	for variable in "${vars2subs[@]}" ; do
		varname=${variable%%=*}
		varval=${variable##*=}
		sed -i \
			-e "s:^\(XCOMM\)*[[:space:]]*${varname}[[:space:]]*=.*$:${varname} = ${varval}:" \
			"$@" || die
	done
	if use nls; then
		sed -i \
			-e "s:^\(XCOMM\)*[[:space:]]*\(#define I18N\).*$:\2:" \
			"$@" || die
		# Fix #405475 and #426780 by Markus Peloquin #405475 comment 17
		sed -i \
			-e 's:^I18N_DEFS[[:space:]]*=.*:& -DXAW_INTERNATIONALIZATION:' \
			"$@" || die
	fi
	if has_version '>=x11-libs/libXaw3d-1.5e'; then
		sed -i \
			-e "s:^\(XCOMM\)*[[:space:]]*\(#define XAW3D1_5E\).*$:\2:" \
			"$@" || die
	fi
}

src_prepare() {
	# Permissions are really crazy here
	chmod -R go+rX . || die
	find . -type f -exec chmod a-x '{}' \; || die
	epatch "${FILESDIR}/${P}-figparserstack.patch" #297379
	epatch "${FILESDIR}/${P}-spelling.patch"
	epatch "${FILESDIR}/${P}-papersize_b1.patch"
	epatch "${FILESDIR}/${P}-pdfimport_mediabox.patch"
	epatch "${FILESDIR}/${P}-network_images.patch"
	epatch "${FILESDIR}/${P}-app-defaults.patch"
	epatch "${FILESDIR}/${P}-zoom-during-edit.patch"
	epatch "${FILESDIR}/${P}-urwfonts.patch"
	epatch "${FILESDIR}/${P}-mkstemp.patch" #264575
	epatch "${FILESDIR}/${P}-CVE-2010-4262.patch" #348344
	epatch "${FILESDIR}/${P}-libpng-1.5.patch" #356753
	#https://bugzilla.redhat.com/show_bug.cgi?id=657290
	epatch "${FILESDIR}/xfig-3.2.5b-fix-eps-reading.patch"
	epatch "${FILESDIR}/${P}-edit-menu.patch" #412753

	sed_Imakefile Imakefile
	sed -e "s:/usr/lib/X11/xfig:${EPREFIX}/usr/share/doc/${PF}:" \
		-i Doc/xfig.man -i Doc/xfig_man.html || die

	#got merge upstream, remove in next release
	epatch "${FILESDIR}"/${P}-darwin.patch
	epatch "${FILESDIR}"/${P}-solaris.patch
}

src_compile() {
	local EXTCFLAGS=${CFLAGS}
	xmkmf || die
	[[ ${CHOST} == *-solaris* ]] && EXTCFLAGS="${EXTCFLAGS} -D_POSIX_SOURCE"
	emake CC="$(tc-getCC)" LOCAL_LDFLAGS="${LDFLAGS}" CDEBUGFLAGS="${EXTCFLAGS}" \
		USRLIBDIR="${EPREFIX}"/usr/$(get_libdir)
}

src_install() {
	emake -j1 DESTDIR="${D}" install.all

	dodoc README FIGAPPS CHANGES LATEX.AND.XFIG

	doicon xfig.png
	make_desktop_entry xfig Xfig xfig
}
