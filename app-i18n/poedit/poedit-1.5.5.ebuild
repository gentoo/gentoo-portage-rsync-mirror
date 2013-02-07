# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/poedit/poedit-1.5.5.ebuild,v 1.1 2013/02/07 04:08:54 dirtyepic Exp $

EAPI=5
WX_GTK_VER=2.8

inherit eutils fdo-mime flag-o-matic wxwidgets

DESCRIPTION="Cross-platform gettext catalogs (.po files) editor."
HOMEPAGE="http://poedit.sourceforge.net/"
SRC_URI="mirror://sourceforge/poedit/${P}.tar.gz"

LICENSE="MIT CCPL-Attribution-2.5 CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="spell"

RDEPEND="dev-libs/boost
	>=sys-libs/db-4.7
	x11-libs/wxGTK:2.8[X]
	spell? ( app-text/gtkspell:2 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-wx28.patch
}

src_configure() {
	append-flags -fno-strict-aliasing
	econf $(use_enable spell spellchecking)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS NEWS README TODO
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
