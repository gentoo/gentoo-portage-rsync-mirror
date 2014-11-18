# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/git-python/git-python-0.3.2.1.ebuild,v 1.1 2014/11/18 10:23:03 jlec Exp $

EAPI=5

#https://github.com/gitpython-developers/GitPython/issues/209
#PYTHON_COMPAT=( python2_7 python3_{3,4} )

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_PN="GitPython"
MY_PV="${PV/_rc/.RC}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Library used to interact with Git repositories"
HOMEPAGE="http://gitorious.org/git-python http://pypi.python.org/pypi/GitPython"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

#Tests dont make sense without a git repo
RESTRICT="test"

RDEPEND="
	dev-vcs/git
	 >=dev-python/gitdb-0.6.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
	)
	"

S="${WORKDIR}/${MY_P}"
