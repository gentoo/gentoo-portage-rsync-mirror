# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/etsprojecttools/etsprojecttools-0.6.0-r1.ebuild,v 1.1 2013/04/12 14:15:12 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} )
#DISTUTILS_SRC_TEST="setup.py"

inherit distutils-r1

MY_PN="ETSProjectTools"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought Tool Suite: Tools for working with projects with many dependencies"
HOMEPAGE="http://code.enthought.com/projects/ets_project_tools.php http://pypi.python.org/pypi/ETSProjectTools"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-vcs/subversion[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	!dev-python/ets
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	sed \
		-e "s/self.run_command('build_docs')/pass/" \
		-e "/setupdocs>=1.0/d" \
		-i setup.py || die "sed setup.py failed"
}

python_test() {
	esetup.py test
}
