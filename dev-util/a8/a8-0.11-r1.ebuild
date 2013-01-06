# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/a8/a8-0.11-r1.ebuild,v 1.2 2013/01/06 18:21:03 hasufell Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 eutils gnome2-utils

DESCRIPTION="An ultra-lightweight IDE, that embeds Vim, a terminal emulator, and a file browser"
HOMEPAGE="http://code.google.com/p/abominade/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/dbus-python-1
	dev-python/logbook
	dev-python/psutil
	dev-python/pyyaml
	>=dev-python/pygtk-2.22
	>=dev-python/pygtkhelpers-0.4.3
	virtual/python-argparse[${PYTHON_USEDEP}]
	x11-libs/vte:0[python]"
RDEPEND="${DEPEND}
	app-editors/gvim
	app-editors/vim"

python_install_all() {
	distutils-r1_python_install_all
	doicon -s 48 a8/data/icons/a8.png
	make_desktop_entry ${PN} ${PN} ${PN} 'Development;IDE'
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
