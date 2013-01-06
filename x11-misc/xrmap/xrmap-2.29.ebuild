# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xrmap/xrmap-2.29.ebuild,v 1.10 2009/05/05 18:04:11 ssuominen Exp $

DESCRIPTION="a X client for generating images of the Earth and manipulating the CIA World data bank"
HOMEPAGE="http://frmas.free.fr/li_1.htm#_Xrmap_"
FULL_DIST="2.10"
SRC_URI="ftp://ftp.ac-grenoble.fr/ge/geosciences/${PN}/${PN}-${FULL_DIST}.tgz
		 ftp://ftp.ac-grenoble.fr/ge/geosciences/${PN}/${P}.tar.bz2
		 ftp://ftp.ac-grenoble.fr/ge/geosciences/CIA_WDB2.jpd.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE="zlib"

RDEPEND="x11-libs/libX11
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-misc/imake
	x11-proto/xproto
	media-gfx/imagemagick
	app-text/gv
	sys-apps/less
	>=sys-apps/sed-4
	zlib? ( sys-libs/zlib )"

src_unpack() {
	unpack ${A}
	rm -rf "${S}"
	mv "${WORKDIR}"/${PN}-${FULL_DIST} "${S}"
	unpack ${A}
	cd "${S}"/editkit && xmkmf || die
}

src_compile() {
	use zlib || sed -i 's/-DZLIB\|-lz//g' Makefile.noimake || die

	sed  -e 's,^\(X11DIR=\).*,\1/usr/,g' \
		 -e 's,^\(EDITOR=\).*,\1less,g'   \
		 -e 's,^\(SHAREDIR=\).*,\1/usr/share/xrmap,g' \
		 -e 's,^\(CCOPTIONS=\)-O6 -g,\1${CFLAGS},g' Makefile.noimake > Makefile || die

	sed -i -e 's,^\(#define RCFILE \)SHAREDIR\",\1\"/etc/xrmap,g'  \
		   -e 's,^\(#define SHAREDIR \"/usr/share/\),\1x,g' xrmap.h || die
	emake || die
	cd tools
	emake || die
	cd jpd2else
	sed -i 's,^\(#define DEFAULT_JPD_FILE \"/usr/share/\),\1x,g' jpd2else.c || die
	emake || die
	cd ../cbd2else
	emake || die
}

src_install() {
	dobin xrmap tools/preproc tools/jpd2else/jpd2else tools/cbd2else/cbd2else || die
	dodir /usr/share/${PN}/ || die
	dodir /etc/xrmap  || die
	cp -r {i18n,Locations,factbook,anthems,flags,hymns,pixmaps} "${D}"/usr/share/${PN}/ || die
	cp Xrmaprc "${D}"/etc/xrmap || die
	cp "${WORKDIR}"/CIA_WDB2.jpd "${D}"/usr/share/${PN}/ || die
	dodoc CHANGES README TODO WARNING tools/cbd2else/README.cbd tools/jpd2else/README.jpd tools/rez2else/README.rez || die

	cd "${S}"
	newman xrmap.man xrmap.1 || die "newman failed"
}
