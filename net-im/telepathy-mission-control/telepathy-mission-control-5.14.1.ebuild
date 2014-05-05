# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/telepathy-mission-control/telepathy-mission-control-5.14.1.ebuild,v 1.9 2014/05/05 13:50:58 tetromino Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
# Needed for tests and build #489466
PYTHON_COMPAT=( python2_{6,7} )

inherit gnome2 python-any-r1

DESCRIPTION="An account manager and channel dispatcher for the Telepathy framework"
HOMEPAGE="http://cgit.freedesktop.org/telepathy/telepathy-mission-control/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~arm-linux ~x86-linux"
IUSE="connman debug gnome-keyring networkmanager +upower" # test
REQUIRED_USE="?? ( connman networkmanager )"

RDEPEND="
	>=dev-libs/dbus-glib-0.82
	>=dev-libs/glib-2.30:2
	>=sys-apps/dbus-0.95
	>=net-libs/telepathy-glib-0.19
	connman? ( net-misc/connman )
	gnome-keyring? ( gnome-base/libgnome-keyring )
	networkmanager? ( >=net-misc/networkmanager-0.7 )
	upower? (
		>=sys-power/upower-0.9.11
		<sys-power/upower-0.99 )
"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	dev-libs/libxslt
	>=dev-util/gtk-doc-am-1.17
	virtual/pkgconfig
"
#	test? ( dev-python/twisted-words )"

# Tests are broken, see upstream bug #29334 and #64212
# upstream doesn't want it enabled everywhere (#29334#c12)
RESTRICT="test"

src_configure() {
	# creds is not available
	gnome2_src_configure \
		 --disable-static \
		$(use_enable debug) \
		$(use_enable gnome-keyring) \
		$(use_with connman connectivity connman) \
		$(use_with networkmanager connectivity nm) \
		$(use_enable upower)
}
