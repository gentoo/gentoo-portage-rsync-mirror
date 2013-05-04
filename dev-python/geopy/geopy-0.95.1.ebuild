# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/geopy/geopy-0.95.1.ebuild,v 1.1 2013/05/04 09:41:34 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1

DESCRIPTION="A Geocoding Toolbox for Python"
HOMEPAGE="http://www.geopy.org/ http://pypi.python.org/pypi/geopy http://code.google.com/p/geopy/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	http://dev.gentoo.org/~idella4/fells_loop.gpx"
IUSE="test"

RDEPEND="<=dev-python/beautifulsoup-4.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

python_prepare_all() {
	# Missing source file, http://code.google.com/p/geopy/issues/detail?id=66&thanks=66&ts=1367561505
	if use test; then
		 cp -r "${DISTDIR}"/fells_loop.gpx geopy/tests/ || die
	fi
}

python_test() {
	nosetests || die "Tests failed under ${EPYTHON}"
}
