# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask-themes/flask-themes-0.1.3-r1.ebuild,v 1.1 2013/06/10 13:12:38 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1

MY_PN="Flask-Themes"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Infrastructure for theming support in Flask applications."
HOMEPAGE="http://packages.python.org/Flask-Themes/ http://pypi.python.org/pypi/Flask-Themes"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/flask-0.6[${PYTHON_USEDEP}]
	virtual/python-json[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}"/fixtests.patch )

python_test() {
	PYTHONPATH=.:tests nosetests || die "Tests failed under ${EPYTHON}"
}
