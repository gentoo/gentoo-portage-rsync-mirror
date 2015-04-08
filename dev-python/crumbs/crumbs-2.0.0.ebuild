# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/crumbs/crumbs-2.0.0.ebuild,v 1.1 2014/09/02 21:32:05 alunduil Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_2 python3_3 )

inherit distutils-r1

DESCRIPTION="Generalized all-in-one parameters module"
HOMEPAGE="https://github.com/alunduil/crumbs"
SRC_URI="https://github.com/alunduil/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="inotify test"

CDEPEND="inotify? ( dev-python/pyinotify[${PYTHON_USEDEP}] )"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		${CDEPEND}
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)
"
RDEPEND="${CDEPEND}"

python_test() {
	nosetests || die "Tests failed on ${EPYTHON}"
}
