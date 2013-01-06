# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/poedit/poedit-1.4.6.1.ebuild,v 1.10 2012/05/03 19:24:33 jdhore Exp $

EAPI=2
WX_GTK_VER=2.8

inherit wxwidgets flag-o-matic fdo-mime

DESCRIPTION="Cross-platform gettext catalogs (.po files) editor."
HOMEPAGE="http://poedit.sourceforge.net/"
SRC_URI="mirror://sourceforge/poedit/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 hppa ppc sparc x86"
IUSE="spell"

RDEPEND="x11-libs/wxGTK:2.8[X]
	>=sys-libs/db-3.1
	spell? ( >=app-text/gtkspell-2.0.0:2 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	append-flags -fno-strict-aliasing
	econf $(use_enable spell spellchecking)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README TODO
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
