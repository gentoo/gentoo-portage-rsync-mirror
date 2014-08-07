# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/farstream/farstream-0.2.4.ebuild,v 1.4 2014/08/07 19:19:28 jer Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python2_7 )

inherit gnome2 python-any-r1

DESCRIPTION="Audio/video conferencing framework specifically designed for instant messengers"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/Farstream"
SRC_URI="http://freedesktop.org/software/farstream/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1+"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="+introspection msn test upnp"

SLOT="0.2"

# Tests need shmsink from gst-plugins-bad, which isn't packaged
RESTRICT="test"

COMMONDEPEND="
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	>=dev-libs/glib-2.32:2
	>=net-libs/libnice-0.1.3-r1
	introspection? ( >=dev-libs/gobject-introspection-0.10.11 )
	upnp? ( >=net-libs/gupnp-igd-0.2:= )
"
RDEPEND="${COMMONDEPEND}
	media-libs/gst-plugins-good:1.0
	media-libs/gst-plugins-bad:1.0
	media-plugins/gst-plugins-libnice:1.0
	msn? ( media-plugins/gst-plugins-mimic:1.0 )
"
DEPEND="${COMMONDEPEND}
	${PYTHON_DEPS}
	dev-util/gtk-doc-am
	virtual/pkgconfig
	test? (
		media-libs/gst-plugins-base:1.0[vorbis]
		media-libs/gst-plugins-good:1.0 )"

pkg_setup() {
	python-any-r1_pkg_setup
}

src_configure() {
	plugins="fsrawconference,fsrtpconference,fsfunnel,fsrtcpfilter,fsvideoanyrate"
	use msn && plugins="${plugins},fsmsnconference"
	gnome2_src_configure \
		--disable-static \
		$(use_enable introspection) \
		$(use_enable upnp gupnp) \
		--with-plugins=${plugins}
}

src_test() {
	# FIXME: do an out-of-tree build for tests if USE=-msn
	if ! use msn; then
		elog "Tests disabled without msn use flag"
		return
	fi

	emake -j1 check
}
