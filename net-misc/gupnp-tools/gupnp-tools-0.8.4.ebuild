# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gupnp-tools/gupnp-tools-0.8.4.ebuild,v 1.2 2012/05/05 03:20:44 jdhore Exp $

EAPI=4

inherit gnome.org

DESCRIPTION="Free replacements of Intel UPnP tools that use GUPnP."
HOMEPAGE="http://gupnp.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.16:2
	>=x11-libs/gtk+-3:3
	>=x11-libs/gtksourceview-3:3.0
	>=x11-themes/gnome-icon-theme-2.20
	>=net-libs/gssdp-0.10
	>=net-libs/gupnp-0.13
	>=net-libs/gupnp-av-0.5.5
	net-libs/libsoup:2.4
	sys-apps/util-linux
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext
"

DOCS=(AUTHORS ChangeLog NEWS README)
