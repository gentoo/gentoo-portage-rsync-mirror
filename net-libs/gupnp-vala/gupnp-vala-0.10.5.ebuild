# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gupnp-vala/gupnp-vala-0.10.5.ebuild,v 1.4 2013/03/30 22:47:52 eva Exp $

EAPI="4"
VALA_MIN_API_VERSION="0.14"
VALA_USE_DEPEND="vapigen"

inherit gnome.org vala

DESCRIPTION="Vala bindings for the GUPnP framework."
HOMEPAGE="http://gupnp.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="$(vala_depend)
	>=net-libs/gupnp-0.18
	>=net-libs/gssdp-0.12.2[introspection]
	>=net-libs/gupnp-av-0.9
	>=media-libs/gupnp-dlna-0.5.1:1.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"
