# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/icalendar/icalendar-3.8.4.ebuild,v 1.3 2015/01/26 10:24:36 ago Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

MY_PN="collective-${PN}"

DESCRIPTION="Package used for parsing and generating iCalendar files (RFC 2445)"
HOMEPAGE="http://github.com/collective/icalendar"
SRC_URI="mirror://pypi/i/${PN}/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd"
IUSE="doc test"
DOCS="README.rst"

RDEPEND="dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? (	dev-python/python-dateutil:0[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}] )"

python_compile_all() {
	if use doc; then
		pushd docs > /dev/null
		emake text
		popd > /dev/null
		DOCS=( ${DOCS} docs/_build/text/*.txt )
	fi
}

python_test() {
	# From tox.ini
	coverage run --source=src/icalendar --omit=*/tests/* --module \
		pytest src/icalendar || die "test failed under ${EPYTHON}"
}
