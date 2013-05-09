# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/hgdistver/hgdistver-0.16.ebuild,v 1.2 2013/05/09 12:20:56 maekke Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="utility lib to generate python package version infos from mercurial tags"
HOMEPAGE="http://bitbucket.org/RonnyPfannschmidt/hgdistver/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="test"

DEPEND="dev-python/setuptools
		test? ( dev-python/pytest )"
RDEPEND=""

#src_test() {
#	testing() {
#		PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" py.test
#	}
#	python_execute_function testing
#}
