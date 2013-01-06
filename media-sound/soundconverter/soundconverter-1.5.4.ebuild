# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/soundconverter/soundconverter-1.5.4.ebuild,v 1.7 2012/05/05 08:50:46 mgorny Exp $

EAPI="4"
PYTHON_DEPEND="2"
GCONF_DEBUG="no"

inherit gnome2 python

DESCRIPTION="A simple sound converter application for the GNOME environment."
HOMEPAGE="http://soundconverter.berlios.de"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="aac flac mp3 vorbis"

# upstream reported, please remove as soon as it's fixed
# http://developer.berlios.de/bugs/?func=detailbug&bug_id=17726&group_id=3213
RESTRICT="test"

RDEPEND=">=dev-python/pygtk-2.12
	dev-python/pygobject:2
	dev-python/gconf-python
	dev-python/libgnome-python
	dev-python/gnome-vfs-python
	gnome-base/libglade
	gnome-base/gconf
	=dev-python/gst-python-0.10*
	=media-plugins/gst-plugins-gnomevfs-0.10*
	vorbis? (
		=media-plugins/gst-plugins-vorbis-0.10*
		=media-plugins/gst-plugins-ogg-0.10*
	)
	mp3? (
		=media-plugins/gst-plugins-lame-0.10*
		=media-plugins/gst-plugins-mad-0.10*
		=media-plugins/gst-plugins-taglib-0.10*
	)
	flac? ( =media-plugins/gst-plugins-flac-0.10* )
	aac? ( =media-plugins/gst-plugins-faac-0.10* )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext
	dev-util/intltool"

pkg_setup() {
	DOCS="AUTHORS ChangeLog README TODO"
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	gnome2_src_prepare
	python_convert_shebangs -r 2 .
}
