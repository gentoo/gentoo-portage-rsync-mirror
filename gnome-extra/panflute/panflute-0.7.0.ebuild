# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/panflute/panflute-0.7.0.ebuild,v 1.7 2012/05/05 06:25:18 jdhore Exp $

EAPI="3"
GCONF_DEBUG="no"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit eutils gnome2 python versionator

MY_MAJORV="$(get_version_component_range 1-2)"

DESCRIPTION="GNOME applet to control various music players"
HOMEPAGE="http://launchpad.net/panflute"
SRC_URI="http://launchpad.net/${PN}/${MY_MAJORV}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="mpd"

# This ebuild is far from perfect, it does a lot of automagic detection
RDEPEND="
	>=dev-python/dbus-python-0.80
	>=dev-libs/dbus-glib-0.71
	dev-python/pygobject:2
	>=x11-libs/pango-1.6
	>=dev-python/gconf-python-2.14
	>=dev-python/gnome-applets-python-2.14
	>=dev-python/notify-python-0.1.1-r2
	>=dev-python/pygtk-2.16:2
	mpd? ( >=dev-python/python-mpd-0.2.1 )
	!gnome-extra/music-applet
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.40
"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README THANKS"
	python_pkg_setup
}

src_prepare() {
	gnome2_src_prepare

	# Upstream: https://bugs.launchpad.net/panflute/+bug/761701
	epatch "${FILESDIR}"/${PN}-0.6.2-libnotify-0.7.patch

	# disable pyc compiling
	>py-compile

	python_copy_sources
}

src_configure() {
	python_execute_function -s gnome2_src_configure
}

src_compile() {
	python_execute_function -s gnome2_src_compile
}

src_test() {
	python_execute_function -s -d
}

src_install() {
	python_execute_function -s gnome2_src_install
	python_clean_installation_image
	python_convert_shebangs -r 2 "${ED}"
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize panflute
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup panflute
}
