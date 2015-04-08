# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ninja-ide/ninja-ide-2.1.1-r3.ebuild,v 1.4 2014/07/06 12:52:10 mgorny Exp $

# XXX: tests

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 )

inherit eutils gnome2-utils distutils-r1 vcs-snapshot

DESCRIPTION="Ninja-IDE Is Not Just Another IDE"
HOMEPAGE="http://www.ninja-ide.org"
SRC_URI="https://github.com/ninja-ide/ninja-ide/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-python/PyQt4[webkit]
	dev-python/pyinotify"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${P}-lang.patch )

python_install_all() {
	distutils-r1_python_install_all
	newicon -s 256 icon.png ${PN}.png
	make_desktop_entry ${PN} "NINJA-IDE"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
