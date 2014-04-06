# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/pitivi/pitivi-0.14.1.ebuild,v 1.4 2014/04/06 15:25:54 eva Exp $

EAPI="3"
GCONF_DEBUG="no"
PYTHON_DEPEND="2:2.5"

inherit eutils gnome2 multilib python virtualx

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
"
RDEPEND="${COMMON_DEPEND}
	dev-python/dbus-python
	>=dev-python/gconf-python-2.12
	dev-python/pygoocanvas
	dev-python/pyxdg
	net-zope/zope-interface
	gnome-base/librsvg

	>=media-libs/gst-plugins-base-0.10.31:0.10
	>=media-libs/gst-plugins-good-0.10.24:0.10
	>=media-plugins/gst-plugins-ffmpeg-0.10:0.10
	>=media-plugins/gst-plugins-xvideo-0.10.31:0.10
	>=media-plugins/gst-plugins-libpng-0.10.24:0.10

	v4l? ( media-plugins/gst-plugins-v4l2:0.10 )
"
DEPEND="${RDEPEND}
	dev-python/setuptools
	sys-devel/gettext
	>=dev-util/intltool-0.35.5
"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS RELEASE"
	python_set_active_version 2
}

src_prepare() {
	gnome2_src_prepare
	python_clean_py-compile_files
}

src_configure() {
	addpredict $(unset HOME; echo ~)/.gconf
	addpredict $(unset HOME; echo ~)/.gconfd
	addpredict $(unset HOME; echo ~)/.gstreamer-0.10

	gnome2_src_configure
}

src_test() {
	export XDG_CONFIG_HOME="${WORKDIR}/.config"
	export XDG_DATA_HOME="${WORKDIR}/.local"
	# Force Xvfb to be used
	unset DISPLAY
	unset DBUS_SESSION_BUS_ADDRESS
	export PITIVI_TOP_LEVEL_DIR="${S}"
	Xemake check || die "tests failed"
}

src_install() {
	gnome2_src_install
	python_convert_shebangs -r 2 "${D}"
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize "/usr/$(get_libdir)/${PN}/python/${PN}"
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup "/usr/$(get_libdir)/${PN}/python/${PN}"
}
