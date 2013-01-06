# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/quodlibet/quodlibet-2.4.ebuild,v 1.8 2012/12/11 17:15:05 ssuominen Exp $

EAPI=4

PYTHON_DEPEND="2:2.7"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 2.6 3.* *-jython 2.7-pypy-*"

inherit distutils eutils

DESCRIPTION="audio library tagger, manager, and player for GTK+"
HOMEPAGE="http://code.google.com/p/quodlibet/"
SRC_URI="http://quodlibet.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="dbus gstreamer ipod"

COMMON_DEPEND=">=dev-python/pygtk-2.12"
RDEPEND="${COMMON_DEPEND}
	dev-python/feedparser
	>=media-libs/mutagen-1.14
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
	ipod? ( media-libs/libgpod[python] )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool"
REQUIRED_USE="ipod? ( dbus )"

src_prepare() {
	# This is properly fixed in 2.4.91, so we don't really bother here
	if has_version '>=virtual/udev-183'; then
		sed -i -e '/LoadLibrary/s:libudev.so.0:libudev.so.1:' ${PN}/devices/__init__.py || die
	fi

	local qlconfig=${PN}/config.py

	if ! use gstreamer; then
		sed -i -e '/backend/s:gstbe:xinebe:' ${qlconfig} || die
	fi

	sed -i -e '/gst_pipeline/s:"":"alsasink":' ${qlconfig} || die

	distutils_src_prepare
}

src_install() {
	distutils_src_install
	dodoc HACKING NEWS README
	doicon ${PN}/images/hicolor/64x64/apps/{exfalso,quodlibet}.png
}
