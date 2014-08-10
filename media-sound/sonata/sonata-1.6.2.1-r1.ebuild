# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sonata/sonata-1.6.2.1-r1.ebuild,v 1.2 2014/08/10 21:12:16 slyfox Exp $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )
DISTUTILS_SINGLE_IMPL=true

inherit distutils-r1

DESCRIPTION="an elegant GTK+ music client for the Music Player Daemon (MPD)"
HOMEPAGE="http://sonata.berlios.de/"
SRC_URI="http://codingteam.net/project/${PN}/download/file/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dbus lyrics taglib +trayicon"

RDEPEND=">=dev-python/pygtk-2.12
	|| ( x11-libs/gdk-pixbuf:2[jpeg] x11-libs/gtk+:2[jpeg] )
	>=dev-python/python-mpd-0.2.1
	dbus? ( dev-python/dbus-python )
	lyrics? ( dev-python/zsi )
	taglib? ( >=dev-python/tagpy-0.93 )
	trayicon? ( dev-python/egg-python )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="CHANGELOG README TODO TRANSLATORS"
PATCHES=( "${FILESDIR}"/${P}-mpd18-compat.patch )

src_install() {
	distutils-r1_src_install
	rm -rf "${D}"/usr/share/sonata
}
