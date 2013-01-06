# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/rubrica/rubrica-2.1.6-r1.ebuild,v 1.7 2012/05/03 20:00:41 jdhore Exp $

EAPI=2
inherit eutils gnome2

MY_PN=${PN}2

DESCRIPTION="A contact database for Gnome"
HOMEPAGE="http://rubrica.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${MY_PN}-${PV}.tar.bz2
	linguas_hu? ( mirror://gentoo/${P}-hu.po.bz2 )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86"
IUSE="linguas_hu"

RDEPEND="dev-libs/glib:2
	dev-libs/libxml2
	>=gnome-base/libglade-2
	gnome-base/gconf:2
	x11-libs/gtk+:2
	x11-libs/libnotify"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	linguas_hu? ( >=sys-devel/gettext-0.16.1 )"

S=${WORKDIR}/${MY_PN}-${PV}

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-dependency-tracking
		--disable-static
		--with-html-dir=/usr/share/doc/${PF}/html"

	DOCS="AUTHORS ChangeLog CREDITS NEWS README TODO"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch
	# False menu in locales
	epatch "${FILESDIR}"/${P}_fix-menu-language.patch
	# Missing gnome icons
	epatch "${FILESDIR}"/${P}_missing-icons.patch
	cd po
	epatch "${FILESDIR}"/${P}_url-crash.patch
}

src_compile() {
	gnome2_src_compile

	# Add Hungarian translation
	if use linguas_hu; then
		msgfmt "${WORKDIR}"/${P}-hu.po --output-file po/hu.gmo || die
	fi
}

src_install() {
	gnome2_src_install

	domenu "${FILESDIR}"/${MY_PN}.desktop

	if use linguas_hu; then
		domo po/hu.gmo || die
		dosym ${PN}.mo /usr/share/locale/hu/LC_MESSAGES/${MY_PN}.mo || die
	fi

	find "${D}" -name '*.la' -exec rm -f '{}' +
}
