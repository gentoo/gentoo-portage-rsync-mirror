# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/listen/listen-0.6.5-r1.ebuild,v 1.2 2012/05/05 09:02:05 mgorny Exp $

EAPI=3
PYTHON_DEPEND="2:2.6"
inherit eutils multilib python

DESCRIPTION="A music management and playback for GTK+ based desktops"
HOMEPAGE="http://www.listen-project.org/"
SRC_URI="http://download.listen-project.org/0.6/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cdda gnome"

RDEPEND="dev-python/dbus-python
	dev-python/gst-python:0.10
	>=dev-python/pygtk-2.8:2
	dev-python/pyinotify
	|| ( dev-python/python-xlib dev-python/egg-python )
	dev-python/pywebkitgtk
	dev-python/pyxdg
	media-libs/libgpod[python]
	media-libs/mutagen
	media-plugins/gst-plugins-meta:0.10
	x11-libs/libnotify
	cdda? ( dev-python/python-musicbrainz )
	gnome? ( dev-python/gnome-vfs-python )"
DEPEND="${RDEPEND}
	app-text/docbook2X
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext
	!media-radio/ax25-apps"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_compile() {
	CHECK_DEPENDS=0 emake PYTHON="$(PYTHON)" || die
}

src_test() { :; } #324719

src_install() {
	DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" emake \
		install || die
	dodoc README
}

pkg_postinst() {
	python_mod_optimize /usr/$(get_libdir)/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/${PN}
}
