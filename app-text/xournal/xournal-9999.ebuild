# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xournal/xournal-9999.ebuild,v 1.5 2013/04/30 20:35:56 dilfridge Exp $

EAPI=5

GCONF_DEBUG=no

inherit gnome2 autotools

DESCRIPTION="Xournal is an application for notetaking, sketching, and keeping a journal using a stylus."
HOMEPAGE="http://xournal.sourceforge.net/"

LICENSE="GPL-2"

SLOT="0"
IUSE="+pdf vanilla"

if [[ "${PV}" != "9999" ]]; then
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz !vanilla? ( http://dev.gentoo.org/~dilfridge/distfiles/${PN}-${PVR}-gentoo.patch.xz )"
	KEYWORDS="~amd64 ~x86"
else
	inherit git-2
	SRC_URI=""
	KEYWORDS=""
	if use vanilla; then
		EGIT_REPO_URI="git://xournal.git.sourceforge.net/gitroot/xournal/xournal"
	else
		EGIT_REPO_URI="git://gitorious.org/gentoo-stuff/xournal-gentoo.git"
		EGIT_BRANCH="gentoo"
	fi
fi

COMMONDEPEND="
	app-text/poppler:=[cairo]
	dev-libs/atk
	dev-libs/glib
	gnome-base/libgnomecanvas
	media-libs/freetype
	media-libs/fontconfig
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/pango
"
RDEPEND="${COMMONDEPEND}
	pdf? ( app-text/poppler[utils] app-text/ghostscript-gpl )
"
DEPEND="${COMMONDEPEND}
	virtual/pkgconfig
"

src_prepare() {
	if ! use vanilla && [[ "${PV}" != "9999" ]]; then
		epatch "${WORKDIR}"/${PN}-${PVR}-gentoo.patch
	fi
	if ! use vanilla; then
		sed -e "s:n       http:n       Gentoo release ${PVR}\\\\n       http:" -i "${S}"/src/xo-interface.c
	fi
	epatch "${FILESDIR}/${PN}-0.4.7-am113.patch"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	emake DESTDIR="${D}" desktop-install

	dodoc ChangeLog AUTHORS README
	dohtml -r html-doc/*
}
