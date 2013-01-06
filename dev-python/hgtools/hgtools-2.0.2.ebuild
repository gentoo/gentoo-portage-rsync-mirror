# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hgtools/hgtools-2.0.2.ebuild,v 1.4 2013/01/01 08:12:01 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_5 python2_6 python2_7 )

inherit distutils-r1

MY_PN=${PN#python-}
S="${WORKDIR}/${MY_PN}-${PV}"
DESCRIPTION="Classes and setuptools plugin for Mercurial repositories"
HOMEPAGE="https://bitbucket.org/jaraco/hgtools/"
SRC_URI="mirror://pypi/h/${MY_PN}/${MY_PN}-${PV}.zip"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="test"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( dev-python/py )"
RDEPEND=""

python_test() {
	"${PYTHON}" setup.py test
}
