# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cliapp/cliapp-1.20140315.ebuild,v 1.7 2015/01/20 08:45:19 ago Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Framework for Unix-like command line programs"
HOMEPAGE="http://liw.fi/cliapp/"
SRC_URI="http://code.liw.fi/debian/pool/main/p/python-${PN}/python-${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="test"

DEPEND="${PYTHON_DEPS}
	test? ( dev-python/CoverageTestRunner )"

src_test() {
	use test && addwrite /proc/self/comm
	local DISTUTILS_NO_PARALLEL_BUILD=1
	distutils-r1_src_test
}

python_test() {
	emake check
}
