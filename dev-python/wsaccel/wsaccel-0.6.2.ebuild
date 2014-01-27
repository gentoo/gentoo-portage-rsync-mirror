# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wsaccel/wsaccel-0.6.2.ebuild,v 1.1 2014/01/27 16:34:53 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="Accelerator for ws4py, AutobahnPython and tornado"
HOMEPAGE="https://pypi.python.org/pypi/wsaccel https://github.com/methane/wsaccel"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

#RDEPEND=""
#DEPEND="
#	test? (	dev-python/nose )"

_python_test() {
	cd tests || die
	nosetests || die
}
