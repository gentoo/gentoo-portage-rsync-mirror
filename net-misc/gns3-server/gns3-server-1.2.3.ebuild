# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gns3-server/gns3-server-1.2.3.ebuild,v 1.1 2015/02/26 06:54:41 bman Exp $

EAPI="5"

PYTHON_COMPAT=( python{3_3,3_4} )

inherit distutils-r1 eutils

DESCRIPTION="GNS3 server to asynchronously manage emulators"
HOMEPAGE="http://www.gns3.net/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/pyzmq-14.3.1[${PYTHON_USEDEP}]
		>=dev-python/netifaces-0.8-r2[${PYTHON_USEDEP}]
		>=www-servers/tornado-3.1.1[${PYTHON_USEDEP}]
		>=dev-python/jsonschema-2.3.0[${PYTHON_USEDEP}]
		>=dev-python/libcloud-0.14.1[${PYTHON_USEDEP}]
		>=app-emulation/dynamips-0.2.12"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

python_prepare_all() {
	# avoid file collisions caused by required tests
	sed -e "s:find_packages():find_packages(exclude=['tests','tests.*']):" -i setup.py || die
	distutils-r1_python_prepare_all
}

pkg_postinst() {
	ewarn "net-misc/gns3-server has several optional packages that must be merged manually for additional functionality."
	ewarn ""
	ewarn "The following is a list of packages that can be added:"
	ewarn "app-emulation/qemu, app-emulation/virtualbox, and net-analyzer/wireshark"
	ewarn ""
	ewarn "The following packages are currently unsupported:"
	ewarn "iouyap and vpcs"
}
