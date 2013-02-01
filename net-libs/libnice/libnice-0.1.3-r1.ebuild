# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnice/libnice-0.1.3-r1.ebuild,v 1.5 2013/02/01 18:17:12 ago Exp $

EAPI="5"

inherit eutils

DESCRIPTION="An implementation of the Interactice Connectivity Establishment standard (ICE)"
HOMEPAGE="http://nice.freedesktop.org/wiki/"
SRC_URI="http://nice.freedesktop.org/releases/${P}.tar.gz"

LICENSE="|| ( MPL-1.1 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="+upnp"

RDEPEND=">=dev-libs/glib-2.13:2
	upnp? ( >=net-libs/gupnp-igd-0.1.3:= )"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	virtual/pkgconfig"

src_configure() {
	# gstreamer plugin split off into media-plugins/gst-plugins-libnice
	econf --disable-static \
		--without-gstreamer \
		--without-gstreamer-0.10 \
		$(use_enable upnp gupnp)
}

src_install() {
	default
	prune_libtool_files --modules
}
