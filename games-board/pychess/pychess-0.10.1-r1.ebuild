# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pychess/pychess-0.10.1-r1.ebuild,v 1.2 2013/01/11 16:46:48 hasufell Exp $

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 )

# inherit base explicitly to avoid overrides on distutils-r1
inherit base fdo-mime gnome2-utils distutils-r1 games

DESCRIPTION="A chess client for Gnome"
HOMEPAGE="http://pychess.googlepages.com/home"
SRC_URI="http://pychess.googlecode.com/files/${P/_/}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gstreamer"

DEPEND="dev-python/librsvg-python
	dev-python/pycairo
	dev-python/pygobject:2
	dev-python/pygtk
	dev-python/pygtksourceview
	dev-python/pysqlite
	gstreamer? ( dev-python/gst-python )
	dev-python/gconf-python
	x11-themes/gnome-icon-theme"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P/_/}

python_install() {
	distutils-r1_python_install --install-scripts="${GAMES_BINDIR}"
}

python_install_all() {
	dodoc AUTHORS README
	prepgamesdirs
}

src_compile() {
	distutils-r1_src_compile
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
	fdo-mime_desktop_database_update
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
}
