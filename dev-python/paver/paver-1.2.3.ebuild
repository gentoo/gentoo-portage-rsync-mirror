# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/paver/paver-1.2.3.ebuild,v 1.6 2014/12/04 09:59:53 ago Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

MY_PN=${PN/p/P}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Python-based software project scripting tool along the lines of Make"
HOMEPAGE="http://www.blueskyonmars.com/projects/paver/ http://pypi.python.org/pypi/Paver"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( $(python_gen_cond_dep 'dev-python/mock[${PYTHON_USEDEP}]' python2_7 pypy)
		dev-python/nose[${PYTHON_USEDEP}] )"

S=${WORKDIR}/${MY_P}

python_test() {
	nosetests || die "Testing failed with ${EPYTHON}"
}
