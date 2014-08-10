# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/sonata/sonata-1.6.2.1.ebuild,v 1.11 2014/08/10 21:12:16 slyfox Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.[45] 3.* *-jython"

inherit distutils

DESCRIPTION="an elegant GTK+ music client for the Music Player Daemon (MPD)"
HOMEPAGE="http://sonata.berlios.de/"
SRC_URI="http://codingteam.net/project/${PN}/download/file/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
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

src_install() {
	distutils_src_install
	rm -rf "${D}"/usr/share/sonata
}
