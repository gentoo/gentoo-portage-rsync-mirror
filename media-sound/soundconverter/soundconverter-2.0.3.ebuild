# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/soundconverter/soundconverter-2.0.3.ebuild,v 1.3 2012/10/17 11:07:19 ago Exp $

EAPI=4

GCONF_DEBUG=no
PYTHON_DEPEND="2:2.7"

inherit gnome2 multilib python

DESCRIPTION="A simple audiofile converter application for the GNOME environment"
HOMEPAGE="http://soundconverter.org/"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="aac flac mp3 vorbis"

RDEPEND="dev-python/gconf-python
	dev-python/gnome-vfs-python
	=dev-python/gst-python-0.10*
	dev-python/pygobject:2
	>=dev-python/pygtk-2.12
	dev-python/libgnome-python
	gnome-base/libglade
	aac? (
		=media-plugins/gst-plugins-faac-0.10*
		=media-plugins/gst-plugins-faad-0.10*
		)
	flac? ( =media-plugins/gst-plugins-flac-0.10* )
	mp3? (
		=media-plugins/gst-plugins-lame-0.10*
		=media-plugins/gst-plugins-mad-0.10*
		=media-plugins/gst-plugins-taglib-0.10*
		)
	vorbis? (
		=media-plugins/gst-plugins-ogg-0.10*
		=media-plugins/gst-plugins-vorbis-0.10*
		)"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	>py-compile
	python_convert_shebangs -r 2 .
	gnome2_src_prepare
}

pkg_postinst() {
	python_mod_optimize /usr/$(get_libdir)/${PN}
	gnome2_pkg_postinst
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/${PN}
	gnome2_pkg_postrm
}
