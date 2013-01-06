# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/osmo/osmo-0.2.10.ebuild,v 1.9 2012/05/03 20:00:38 jdhore Exp $

EAPI=3
inherit eutils flag-o-matic

DESCRIPTION="A handy personal organizer"
HOMEPAGE="http://clayo.org/osmo/"
SRC_URI="mirror://sourceforge/${PN}-pim/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.12:2
	>=dev-libs/libtar-1.2.11-r3
	dev-libs/libxml2:2
	dev-libs/libgringotts
	>=dev-libs/libical-0.33
	app-text/gtkspell:2
	gnome-extra/gtkhtml:2
	>=x11-libs/libnotify-0.7"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch
}

src_configure() {
	append-flags -I/usr/include/libical

	econf \
		--disable-dependency-tracking \
		--without-libsyncml
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TRANSLATORS
}
