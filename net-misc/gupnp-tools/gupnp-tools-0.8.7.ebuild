# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gupnp-tools/gupnp-tools-0.8.7.ebuild,v 1.1 2013/08/25 21:48:12 eva Exp $

EAPI="5"

inherit gnome.org

DESCRIPTION="Free replacements of Intel UPnP tools that use GUPnP."
HOMEPAGE="http://gupnp.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.24:2
	>=dev-libs/libxml2-2.4:2
	>=net-libs/gssdp-0.13.3
	>=net-libs/gupnp-0.18
	>=net-libs/gupnp-av-0.5.5
	net-libs/libsoup:2.4
	sys-apps/util-linux
	>=x11-libs/gtk+-3:3
	>=x11-libs/gtksourceview-3.2:3.0
	>=x11-themes/gnome-icon-theme-2.20
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40.6
	sys-devel/gettext
	virtual/pkgconfig
"
