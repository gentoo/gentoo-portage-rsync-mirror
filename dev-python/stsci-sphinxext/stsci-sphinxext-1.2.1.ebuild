# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/stsci-sphinxext/stsci-sphinxext-1.2.1.ebuild,v 1.1 2014/02/05 23:22:34 bicatali Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
MY_PN=${PN/-/.}
MY_P=${MY_PN}-${PV}

inherit distutils-r1

DESCRIPTION="Tools and templates to customize Sphinx for STScI projects"
HOMEPAGE="http://www.stsci.edu/resources/software_hardware/stsci_python"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/numpydoc[python_targets_python2_6?,python_targets_python2_7?]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"
