# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/CoverageTestRunner/CoverageTestRunner-1.9.ebuild,v 1.1 2012/10/06 23:28:09 mschiff Exp $

EAPI=4

PYTHON_DEPEND="2:2.6:2.7"

inherit distutils python

MY_PN="python-coverage-test-runner"
DESCRIPTION="fail Python program unit tests unless they test everything"
HOMEPAGE="http://liw.fi/coverage-test-runner/"
SRC_URI="http://code.liw.fi/debian/pool/main/p/${MY_PN}/${MY_PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/coverage"
RDEPEND="${DEPEND}"
