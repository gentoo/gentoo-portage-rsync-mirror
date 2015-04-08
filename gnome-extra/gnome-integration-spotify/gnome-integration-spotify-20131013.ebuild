# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-integration-spotify/gnome-integration-spotify-20131013.ebuild,v 1.1 2013/10/14 03:15:22 prometheanfire Exp $

EAPI=4

inherit gnome2-utils

DESCRIPTION="GNOME integration for Spotify"
HOMEPAGE="https://github.com/mrpdaemon/gnome-integration-spotify"
SRC_URI="http://github.com/mrpdaemon/${PN}/tarball/${PV} -> ${PN}-git-${PV}.tgz"
S="${WORKDIR}/mrpdaemon-${PN}-df9124d"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-lang/python
	dev-python/dbus-python
	media-gfx/imagemagick
	x11-misc/wmctrl
	x11-misc/xautomation
	x11-misc/xdotool
	x11-apps/xwininfo"

src_install() {
	dobin spotify-dbus.py
	mkdir -p "${D}/etc/gconf/schemas"
	cp spotify.schemas "${D}/etc/gconf/schemas"
}

pkg_preinst() {
	gnome2_gconf_savelist
}

pkg_postinst() {
	gnome2_gconf_install
}

pkg_prerm() {
	gnome2_gconf_uninstall
}
