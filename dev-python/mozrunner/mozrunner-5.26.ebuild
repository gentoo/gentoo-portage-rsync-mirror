# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mozrunner/mozrunner-5.26.ebuild,v 1.1 2013/11/07 06:11:56 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Reliable start/stop/configuration of Mozilla Applications (Firefox, Thunderbird, etc.)"
HOMEPAGE="http://pypi.python.org/pypi/mozrunner"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=">=dev-python/mozinfo-0.3.3[${PYTHON_USEDEP}]
	>=dev-python/mozprofile-0.10[${PYTHON_USEDEP}]
	>=dev-python/mozprocess-0.10[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]
	dev-python/mozfile[${PYTHON_USEDEP}]"

python_prepare_all() {
	sed -e 's/\(moz.*\) ==/\1 >=/' -i setup.py
	distutils-r1_python_prepare_all
}
