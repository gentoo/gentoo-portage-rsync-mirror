# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/quodlibet/quodlibet-2.6.3.ebuild,v 1.1 2014/02/17 19:52:24 ssuominen Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )
inherit distutils-r1 gnome2-utils fdo-mime

DESCRIPTION="audio library tagger, manager, and player for GTK+"
HOMEPAGE="http://code.google.com/p/quodlibet/"
SRC_URI="http://bitbucket.org/lazka/${PN}-files/raw/default/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="+dbus gstreamer ipod +udev"

COMMON_DEPEND=">=dev-python/pygtk-2.24"
RDEPEND="${COMMON_DEPEND}
	dev-libs/keybinder:0[python]
	dev-python/feedparser
	dev-python/pygobject:2
	>=media-libs/mutagen-1.20
	gstreamer? (
		>=dev-python/gst-python-0.10.2:0.10
		media-libs/gst-plugins-good:0.10
		media-plugins/gst-plugins-meta:0.10
		)
	!gstreamer? ( media-libs/xine-lib )
	dbus? (
		app-misc/media-player-info
		dev-python/dbus-python
		)
	ipod? ( media-libs/libgpod[python] )
	udev? ( virtual/udev )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool"
REQUIRED_USE="ipod? ( dbus )"

src_prepare() {
	sed -i -e '/usr.*bin.*env/s:python:python2:' {exfalso,quodlibet}.py || die

	local qlconfig=${PN}/config.py

	if ! use gstreamer; then
		sed -i -e '/backend/s:gstbe:xinebe:' ${qlconfig} || die
	fi

	sed -i -e '/gst_pipeline/s:"":"alsasink":' ${qlconfig} || die

	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install
	dodoc NEWS README
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
