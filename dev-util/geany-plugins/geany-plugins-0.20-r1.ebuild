# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/geany-plugins/geany-plugins-0.20-r1.ebuild,v 1.6 2012/05/04 17:51:45 jdhore Exp $

EAPI="2"

inherit autotools autotools-utils eutils versionator

DESCRIPTION="A collection of different plugins for Geany"
HOMEPAGE="http://plugins.geany.org/geany-plugins"
SRC_URI="http://plugins.geany.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="enchant gtkspell lua nls soup webkit"

LINGUAS="be ca da de es fr gl ja pt pt_BR ru tr zh_CN"

RDEPEND=">=dev-util/geany-$(get_version_component_range 1-2)
	dev-libs/libxml2:2
	dev-libs/glib:2
	enchant? ( app-text/enchant )
	gtkspell? ( app-text/gtkspell:2 )
	lua? ( dev-lang/lua )
	soup? ( net-libs/libsoup )
	webkit? (
		net-libs/webkit-gtk:2
		x11-libs/gtk+:2
		x11-libs/gdk-pixbuf:2
		)"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	virtual/pkgconfig"

src_prepare() {
	# https://sourceforge.net/tracker/?func=detail&aid=3163117&group_id=222729&atid=1056532
	epatch "${FILESDIR}"/${P}-geanyprj-outsrc-tests.patch

	# geany-0.21 doesn't have #include <config.h> in its geanyplugin.h,
	# breaking <=geany-plugins-0.20.
	epatch "${FILESDIR}"/${P}-config.h.patch

	eautomake
}

src_configure() {
	# GeanyGenDoc requires ctpl which isn't yet in portage
	local myeconfargs=(
		--docdir=/usr/share/doc/${PF}
		--disable-geanygendoc
		$(use_enable enchant spellcheck)
		$(use_enable gtkspell)
		$(use_enable lua geanylua)
		$(use_enable nls)
		$(use_enable soup updatechecker)
		$(use_enable webkit webhelper)
	)

	autotools-utils_src_configure
}
