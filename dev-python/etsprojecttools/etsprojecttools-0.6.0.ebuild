# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/etsprojecttools/etsprojecttools-0.6.0.ebuild,v 1.5 2012/11/08 10:20:21 idella4 Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="ETSProjectTools"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought Tool Suite: Tools for working with projects with many dependencies"
HOMEPAGE="http://code.enthought.com/projects/ets_project_tools.php http://pypi.python.org/pypi/ETSProjectTools"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/setuptools
	dev-vcs/subversion"
DEPEND="${RDEPEND}
	!dev-python/ets
	test? ( dev-python/nose )"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	distutils_src_prepare

	sed \
		-e "s/self.run_command('build_docs')/pass/" \
		-e "/setupdocs>=1.0/d" \
		-i setup.py || die "sed setup.py failed"
}
