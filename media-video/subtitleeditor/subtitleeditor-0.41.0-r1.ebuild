# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/subtitleeditor/subtitleeditor-0.41.0-r1.ebuild,v 1.2 2014/05/04 08:54:18 pacho Exp $

EAPI=5
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2 versionator flag-o-matic

DESCRIPTION="GTK+2 subtitle editing tool"
HOMEPAGE="http://home.gna.org/subtitleeditor/"
SRC_URI="http://download.gna.org/${PN}/$(get_version_component_range 1-2)/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug nls opengl"

RDEPEND="
	app-text/iso-codes
	>=dev-cpp/gtkmm-2.14:2.4
	>=dev-cpp/glibmm-2.16.3:2
	>=dev-cpp/libxmlpp-2.20:2.6
	>=app-text/enchant-1.4
	>=dev-cpp/gstreamermm-0.10.6
	>=media-libs/gst-plugins-good-0.10:0.10
	>=media-plugins/gst-plugins-meta-0.10-r2:0.10
	>=media-plugins/gst-plugins-pango-0.10:0.10
	>=media-plugins/gst-plugins-xvideo-0.10:0.10
	opengl? ( >=dev-cpp/gtkglextmm-1.2 )
"
# gst-plugins-pango needed for text overlay
# gst-plugins-xvideo needed for video output
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	virtual/pkgconfig
"

src_prepare() {
	# Get textoverlay working with gstreamermm 0.10.11
	epatch "${FILESDIR}/${P}-textoverlay.patch"

	# Prevent crash when generating keyframes with gstreamermm 0.10.11
	epatch "${FILESDIR}/${P}-keyframe-generation.patch"

	gnome2_src_prepare
}

src_configure() {
	export GST_REGISTRY="${T}/home/registry.cache.xml"

	# Avoid using --enable-debug as it mocks with CXXFLAGS and LDFLAGS
	use debug && append-flags -DDEBUG

	gnome2_src_configure \
		--disable-debug \
		$(use_enable nls) \
		$(use_enable opengl gl)
}
