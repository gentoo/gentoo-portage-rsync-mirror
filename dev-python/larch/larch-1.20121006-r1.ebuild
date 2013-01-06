# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/larch/larch-1.20121006-r1.ebuild,v 1.1 2012/10/07 00:40:09 mschiff Exp $

EAPI=4

PYTHON_DEPEND="2:2.6:2.7"

inherit distutils python

DESCRIPTION="Copy-on-write B-tree data structure"
HOMEPAGE="http://liw.fi/larch/"
SRC_URI="http://code.liw.fi/debian/pool/main/p/python-${PN}/python-${PN}_${PV}.orig.tar.gz"
#RESTRICT="test"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="test? ( dev-python/CoverageTestRunner dev-util/cmdtest )"

RDEPEND="dev-python/cliapp
	dev-python/tracing
	dev-python/ttystatus"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_test() {
	# remove build directory so tests will not fail
	# due to tests defined twice
	rm -rf "${S}"/build
	default
}
