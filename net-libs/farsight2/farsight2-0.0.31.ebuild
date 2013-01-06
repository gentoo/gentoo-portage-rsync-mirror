# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/farsight2/farsight2-0.0.31.ebuild,v 1.9 2012/12/08 00:58:20 tetromino Exp $

EAPI="4"
PYTHON_DEPEND="2"

inherit python

DESCRIPTION="Audio/video conferencing framework specifically designed for instant messengers"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/Farstream"
SRC_URI="http://freedesktop.org/software/farstream/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1+"
KEYWORDS="alpha amd64 ~arm ~hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux"
IUSE="python msn upnp"
# IUSE="python test msn upnp"

SLOT="0"

# Tests often fail due to races
RESTRICT="test"

COMMONDEPEND=">=media-libs/gstreamer-0.10.33:0.10
	>=media-libs/gst-plugins-base-0.10.33:0.10
	>=dev-libs/glib-2.26:2
	>=net-libs/libnice-0.1.0
	python? (
		>=dev-python/pygobject-2.16:2
		>=dev-python/gst-python-0.10.10 )
	upnp? ( net-libs/gupnp-igd )"

RDEPEND="${COMMONDEPEND}
	>=media-libs/gst-plugins-good-0.10.17:0.10
	>=media-libs/gst-plugins-bad-0.10.17:0.10
	|| (
		>=media-plugins/gst-plugins-libnice-0.1.0:0.10
		<=net-libs/libnice-0.1.3[gstreamer] )
	msn? ( >=media-plugins/gst-plugins-mimic-0.10.17:0.10 )"

DEPEND="${COMMONDEPEND}
	        virtual/pkgconfig"
#	test? ( media-plugins/gst-plugins-vorbis
#		media-plugins/gst-plugins-speex )

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_configure() {
	plugins="fsrtpconference,funnel,rtcpfilter,videoanyrate"
	use msn && plugins="${plugins},fsmsnconference"
	econf --disable-static \
		$(use_enable python) \
		$(use_enable upnp gupnp) \
		--with-plugins=${plugins}
}

src_install() {
	default

	# Remove .la files since static libs are no longer being installed
	find "${D}" -name '*.la' -exec rm -f '{}' + || die
}

src_test() {
	# FIXME: do an out-of-tree build for tests if USE=-msn
	if ! use msn; then
		elog "Tests disabled without msn use flag"
		return
	fi

	emake -j1 check
}
