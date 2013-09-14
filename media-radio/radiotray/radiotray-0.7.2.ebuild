# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/radiotray/radiotray-0.7.2.ebuild,v 1.7 2013/09/13 23:58:59 hwoarang Exp $

EAPI=3

PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Online radio streaming player"
HOMEPAGE="http://radiotray.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-1+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="sys-apps/dbus[X]
	dev-python/dbus-python
	dev-python/gst-python:0.10
	dev-python/pygtk
	dev-python/lxml
	dev-python/pyxdg
	dev-python/pygobject:2
	dev-python/notify-python
	media-libs/gst-plugins-good:0.10
	media-libs/gst-plugins-ugly:0.10
	media-plugins/gst-plugins-alsa:0.10
	media-plugins/gst-plugins-libmms:0.10
	media-plugins/gst-plugins-ffmpeg:0.10
	media-plugins/gst-plugins-mad:0.10
	media-plugins/gst-plugins-ogg:0.10
	media-plugins/gst-plugins-soup:0.10
	media-plugins/gst-plugins-vorbis:0.10"

DEPEND="dev-python/pyxdg"
