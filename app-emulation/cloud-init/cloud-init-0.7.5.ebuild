# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/cloud-init/cloud-init-0.7.5.ebuild,v 1.1 2014/05/01 16:12:51 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils multilib

DESCRIPTION="Package provides configuration and customization of cloud instance."
HOMEPAGE="https://launchpad.net/cloud-init"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/cheetah[${PYTHON_USEDEP}]
		>=dev-python/prettytable-0.7.1[${PYTHON_USEDEP}]
		dev-python/oauth[${PYTHON_USEDEP}]
		dev-python/pyserial[${PYTHON_USEDEP}]
		dev-python/configobj[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		virtual/python-argparse[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/jsonpatch[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( ${RDEPEND} )"

PATCHES=( "${FILESDIR}"/${P}-tests-exclude.patch )

python_test() {
	emake test
}

python_install() {
	distutils-r1_python_install
	for svc in config final init init-local; do
		newinitd "${FILESDIR}/cloud-${svc}.init" "cloud-${svc}"
	done
}
