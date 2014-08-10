# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/fabric/fabric-1.2.2.ebuild,v 1.2 2014/08/10 21:10:24 slyfox Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="Fabric"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Fabric is a simple, Pythonic tool for remote execution and deployment"
HOMEPAGE="http://fabfile.org http://pypi.python.org/pypi/Fabric"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/paramiko-1.7.6"
DEPEND="${RDEPEND}
	dev-python/setuptools"

# Tests broken.
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

PYTHON_MODULES="fabfile fabric"

src_prepare() {
	distutils_src_prepare
	sed -e "/install_requires=/s/'pycrypto >= 1.9', //" -i setup.py || die "sed failed"
}
