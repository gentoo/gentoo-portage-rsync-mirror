# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gupnp-tools/gupnp-tools-0.8.ebuild,v 1.2 2012/05/05 03:20:44 jdhore Exp $

EAPI=2

DESCRIPTION="Free replacements of Intel UPnP tools that use GUPnP."
HOMEPAGE="http://gupnp.org/"
SRC_URI="http://gupnp.org/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16:2
	>=x11-libs/gtk+-2.16:2
	>=x11-themes/gnome-icon-theme-2.20
	>=net-libs/gupnp-0.13
	>=net-libs/gupnp-av-0.5"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

src_configure() {
	econf \
		--disable-dependency-tracking
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
