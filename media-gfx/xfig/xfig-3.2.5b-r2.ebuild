# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xfig/xfig-3.2.5b-r2.ebuild,v 1.2 2013/06/07 14:23:46 jer Exp $

EAPI="2"
inherit eutils multilib

MY_P=${PN}.${PV}

DESCRIPTION="A menu-driven tool to draw and manipulate objects interactively in an X window."
HOMEPAGE="http://www.xfig.org"
SRC_URI="mirror://sourceforge/mcj/${MY_P}.full.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/libXaw
		x11-libs/libXp
		x11-libs/libXaw3d
		x11-libs/libXi
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
	vars2subs=( BINDIR=/usr/bin
		PNGINC=-I/usr/include
		JPEGLIBDIR="/usr/$(get_libdir)"
		JPEGINC=-I/usr/include
		XPMLIBDIR="/usr/$(get_libdir)"
		XPMINC=-I/usr/include/X11
		"USEINLINE = -DUSE_INLINE"
		XFIGLIBDIR=/usr/share/xfig
		XFIGDOCDIR="/usr/share/doc/${PF}"
		MANDIR="/usr/share/man/man\$\(MANSUFFIX\)"
		"CC=$(tc-getCC)" )

	for variable in "${vars2subs[@]}" ; do
		varname=${variable%%=*}
		varval=${variable##*=}
		sed -i \
			-e "s:^\(XCOMM\)*[[:space:]]*${varname}[[:space:]]*=.*$:${varname} = ${varval}:" \
			"$@" || die
	done
	sed -i \
		-e "s:^\(XCOMM\)*[[:space:]]*\(#define I18N\).*$:\2:" \
		"$@" || die
	if has_version '>=x11-libs/libXaw3d-1.5e'; then
		einfo "x11-libs/libXaw3d 1.5e and abover installed"
		sed -i \
			-e "s:^\(XCOMM\)*[[:space:]]*\(#define XAW3D1_5E\).*$:\2:" \
			"$@" || die
	fi
}

src_prepare() {
	# Permissions are really crazy here
	chmod -R go+rX .
	find . -type f -exec chmod a-x '{}' \;
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

	sed_Imakefile Imakefile
	sed -e "s:/usr/lib/X11/xfig:/usr/share/doc/${PF}:" \
		-i Doc/xfig.man -i Doc/xfig_man.html || die
}

src_compile() {
	xmkmf || die
	emake CC="$(tc-getCC)" LOCAL_LDFLAGS="${LDFLAGS}" CDEBUGFLAGS="${CFLAGS}" \
		USRLIBDIR=/usr/$(get_libdir) || die
}

src_install() {
	emake -j1 DESTDIR="${D}" install.all || die

	insinto /usr/share/doc/${PF}
	doins README FIGAPPS CHANGES LATEX.AND.XFIG

	doicon xfig.png
	make_desktop_entry xfig Xfig xfig
}
