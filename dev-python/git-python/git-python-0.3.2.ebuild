# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/git-python/git-python-0.3.2.ebuild,v 1.1 2014/11/18 07:49:34 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
#Tests dont make sense without a git repo

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
IUSE=""

RDEPEND="
	dev-vcs/git
	 >=dev-python/gitdb-0.5.4[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"
