# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/pitivi/pitivi-0.15.2.ebuild,v 1.1 2013/02/05 19:50:19 pacho Exp $

EAPI=5
GCONF_DEBUG="no"
PYTHON_COMPAT=( python2_{5,6,7} )

inherit gnome2 python-single-r1 eutils virtualx multilib

DESCRIPTION="A non-linear video editor using the GStreamer multimedia framework"
HOMEPAGE="http://www.pitivi.org"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="v4l"

# Test fails by not finding audiosink ?
RESTRICT="test"

# gst-plugins-good-0.10.24 needed for prefer-passthrough property
# gst-plugins-base-0.10.31 needed for add-borders property, and decodebin2
COMMON_DEPEND="
	>=dev-python/pygtk-2.18:2
	dev-python/pycairo

	>=media-libs/gstreamer-0.10.28:0.10
	>=dev-python/gst-python-0.10.19:0.10
	>=media-libs/gnonlin-0.10.16:0.10
	>=x11-libs/gtk+-2.24.0:2"
RDEPEND="${COMMON_DEPEND}
	dev-python/dbus-python
	dev-python/pygoocanvas
	dev-python/pyxdg
	net-zope/zope-interface
	gnome-base/librsvg:=

	>=media-libs/gst-plugins-base-0.10.31:0.10
	>=media-libs/gst-plugins-good-0.10.24:0.10
	>=media-plugins/gst-plugins-ffmpeg-0.10:0.10
	>=media-plugins/gst-plugins-xvideo-0.10.31:0.10
	>=media-plugins/gst-plugins-libpng-0.10.24:0.10

	v4l? ( media-plugins/gst-plugins-v4l2:0.10 )"
DEPEND="${RDEPEND}
	dev-python/setuptools
	sys-devel/gettext
	>=app-text/gnome-doc-utils-0.18.0
	>=dev-util/intltool-0.35.5"

DOCS="AUTHORS ChangeLog NEWS RELEASE"

src_test() {
	# Force Xvfb to be used
	unset DISPLAY
	unset DBUS_SESSION_BUS_ADDRESS
	export PITIVI_TOP_LEVEL_DIR="${S}"
	Xemake check || die "tests failed"
}

src_install() {
	gnome2_src_install
	python_fix_shebang "${D}"
}
