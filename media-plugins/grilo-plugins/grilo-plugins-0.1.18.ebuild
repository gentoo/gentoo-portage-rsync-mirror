# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/grilo-plugins/grilo-plugins-0.1.18.ebuild,v 1.8 2012/12/15 18:41:09 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no" # --enable-debug only changes CFLAGS
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2

DESCRIPTION="A framework for easy media discovery and browsing"
HOMEPAGE="https://live.gnome.org/Grilo"

LICENSE="LGPL-2.1+"
SLOT="0.1"
KEYWORDS="amd64 x86"
IUSE="upnp-av +vimeo +youtube"

RDEPEND="
	>=dev-libs/glib-2.26:2
	~media-libs/grilo-${PV}:${SLOT}[network]

	dev-libs/gmime:2.6
	dev-libs/libxml2:2
	dev-db/sqlite:3

	youtube? ( >=dev-libs/libgdata-0.7
		>=media-libs/libquvi-0.2.15 )
	upnp-av? ( >=net-libs/gupnp-0.13
		>=net-libs/gupnp-av-0.5 )
	vimeo? ( net-libs/libsoup:2.4
		dev-libs/libgcrypt )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

# `make check` doesn't do anything, and ${S}/test/test fails without all plugins
RESTRICT="test"

pkg_setup() {
	DOCS="AUTHORS NEWS README"
	# --enable-debug only changes CFLAGS, useless for us
	G2CONF="${G2CONF}
		--disable-static
		--disable-debug
		--disable-uninstalled"

	# Plugins
	# TODO: Enable Blip.TV support (requires librest)
	G2CONF="${G2CONF}
		--enable-apple-trailers
		--enable-bookmarks
		--enable-filesystem
		--enable-flickr
		--enable-gravatar
		--enable-jamendo
		--enable-lastfm-albumart
		--enable-localmetadata
		--enable-metadata-store
		--enable-podcasts
		--disable-bliptv
		--disable-shoutcast
		--disable-tracker
		$(use_enable upnp-av upnp)
		$(use_enable vimeo)
		$(use_enable youtube)"
}

src_prepare() {
	sed -i -e 's/^\(SUBDIRS .*\)test/\1/g' Makefile.*

	# Upstream patches, will be in next release
	epatch "${FILESDIR}/${P}-tracker-0.14.patch" # requires eautoreconf

	eautoreconf

	gnome2_src_prepare
}
