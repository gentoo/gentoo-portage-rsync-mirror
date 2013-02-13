# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pastedeploy/pastedeploy-1.5.0-r1.ebuild,v 1.1 2013/02/12 23:48:25 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit distutils-r1

MY_PN="PasteDeploy"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Load, configure, and compose WSGI applications and servers"
HOMEPAGE="http://pythonpaste.org/deploy/ http://pypi.python.org/pypi/PasteDeploy"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="doc"

RDEPEND="dev-python/paste[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

python_install_all() {
	distutils-r1_python_install_all

	use doc && dodoc docs/*.txt
}
