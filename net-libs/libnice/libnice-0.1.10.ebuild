# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnice/libnice-0.1.10.ebuild,v 1.6 2015/03/29 11:01:50 jer Exp $

EAPI=5
inherit eutils multilib-minimal

DESCRIPTION="An implementation of the Interactice Connectivity Establishment standard (ICE)"
HOMEPAGE="http://nice.freedesktop.org/wiki/"
SRC_URI="http://nice.freedesktop.org/releases/${P}.tar.gz"

LICENSE="|| ( MPL-1.1 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="+introspection +upnp"

RDEPEND="
	>=dev-libs/glib-2.34.3:2[${MULTILIB_USEDEP}]
	introspection? ( >=dev-libs/gobject-introspection-1.30.0 )
	upnp? ( >=net-libs/gupnp-igd-0.2.4:=[${MULTILIB_USEDEP}] )
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	>=virtual/pkgconfig-0-r1[${MULTILIB_USEDEP}]
"

# Many tests fail from time to time, for example:
# https://bugs.freedesktop.org/show_bug.cgi?id=81691
RESTRICT="test"

multilib_src_configure() {
	# gstreamer plugin split off into media-plugins/gst-plugins-libnice
	ECONF_SOURCE=${S} \
	econf \
		--disable-static \
		--disable-static-plugins \
		--without-gstreamer \
		--without-gstreamer-0.10 \
		$(multilib_native_use_enable introspection) \
		$(use_enable upnp gupnp)

	if multilib_is_native_abi; then
		ln -s {"${S}"/,}docs/reference/libnice/html || die
	fi
}

multilib_src_install_all() {
	einstalldocs
	prune_libtool_files --modules
}
