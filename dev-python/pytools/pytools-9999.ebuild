# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pytools/pytools-9999.ebuild,v 1.5 2013/08/25 03:23:58 floppym Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit distutils-r1 git-2

DESCRIPTION="A collection of tools missing from the Python standard library"
HOMEPAGE="http://mathema.tician.de/software/pytools"
EGIT_REPO_URI="http://git.tiker.net/trees/pytools.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

DEPEND="
	>=dev-python/setuptools-0.7.2[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/decorator[${PYTHON_USEDEP}] )"
RDEPEND=""

python_test() {
	py.test || die "Tests fail with ${EPYTHON}"
}
