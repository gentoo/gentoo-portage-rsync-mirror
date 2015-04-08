# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gns3-gui/gns3-gui-1.2.3.ebuild,v 1.1 2015/02/26 06:57:43 bman Exp $

EAPI="5"

PYTHON_COMPAT=( python{3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Graphical Network Simulator"
HOMEPAGE="http://www.gns3.net/"
SRC_URI="https://github.com/GNS3/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#net-misc/gns3-server version should always match gns3-gui version
#block net-misc/gns3 as it conflicts

RDEPEND=">=dev-python/libcloud-0.15.1[${PYTHON_USEDEP}]
	>=dev-python/ws4py-0.3.4[${PYTHON_USEDEP}]
	>=dev-python/requests-2.3.0[${PYTHON_USEDEP}]
	>=dev-python/paramiko-1.13.0[${PYTHON_USEDEP}]
	!=dev-python/PyQt4-4.11.3_pre20141024[${PYTHON_USEDEP}]
	>=dev-python/PyQt4-4.11.2[X,svg,${PYTHON_USEDEP}]
	dev-qt/qtgui:4
	dev-qt/qtsvg:4
	net-misc/gns3-converter[${PYTHON_USEDEP}]
	=net-misc/gns3-server-$PV[${PYTHON_USEDEP}]
	!!net-misc/gns3"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_prepare_all() {
	# avoid file collisions caused by required tests
	sed -e "s:find_packages():find_packages(exclude=['tests','tests.*']):" -i setup.py || die
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all

	doicon "${WORKDIR}/${P}/resources/images/gns3.ico"
	make_desktop_entry "gns3" "GNS3" "/usr/share/pixmaps/gns3.ico" "Utility"
}
