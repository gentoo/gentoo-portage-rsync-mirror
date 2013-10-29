# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/cloud-init/cloud-init-0.7.2.ebuild,v 1.2 2013/10/29 04:42:05 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils multilib

DESCRIPTION="Package provides configuration and customization of cloud instance."
HOMEPAGE="https://launchpad.net/cloud-init"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

RDEPEND="dev-python/cheetah[${PYTHON_USEDEP}]
		dev-python/prettytable[${PYTHON_USEDEP}]
		dev-python/oauth[${PYTHON_USEDEP}]
		dev-python/pyserial[${PYTHON_USEDEP}]
		dev-python/configobj[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		virtual/python-argparse[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/boto[${PYTHON_USEDEP}]
		dev-python/jsonpatch[${PYTHON_USEDEP}]"

src_prepare() {
	sed -i "s/'tests'//g" "${S}/setup.py"
	rm -R "${S}/tests"
}
