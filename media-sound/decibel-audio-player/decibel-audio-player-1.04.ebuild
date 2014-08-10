# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/decibel-audio-player/decibel-audio-player-1.04.ebuild,v 1.6 2014/08/10 21:05:11 slyfox Exp $

EAPI="1"

DESCRIPTION="A GTK+ audio player which aims at being very straightforward to use"
HOMEPAGE="http://decibel.silent-blade.org"
SRC_URI="http://decibel.silent-blade.org/uploads/Main/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="aac cdda gnome gnome-keyring libnotify musepack wavpack"

RDEPEND="media-libs/mutagen
	dev-python/dbus-python
	dev-python/gst-python:0.10
	dev-python/imaging
	>=media-plugins/gst-plugins-meta-0.10-r2:0.10
	aac? ( media-plugins/gst-plugins-faad:0.10 )
	cdda? ( || ( media-plugins/gst-plugins-cdio:0.10
		media-plugins/gst-plugins-cdparanoia:0.10 )
		dev-python/cddb-py )
	gnome? ( dev-python/gnome-python-base )
	gnome-keyring? ( dev-python/gnome-keyring-python )
	libnotify? ( dev-python/notify-python )
	musepack? ( media-plugins/gst-plugins-musepack:0.10 )
	wavpack? ( media-plugins/gst-plugins-wavpack:0.10 )"
DEPEND="sys-devel/gettext"

src_install() {
	emake DESTDIR="${D}" prefix=/usr \
		install || die "emake install failed"
	dodoc doc/ChangeLog || die "dodoc failed"
}

pkg_postinst() {
	elog "Please read the Decibel guide at"
	elog "http://www.gentoo.org/proj/en/desktop/sound/decibel.xml; it contains"
	elog "information on how to enable various features and audio formats."
}
