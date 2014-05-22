# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/weasyprint/weasyprint-0.22.ebuild,v 1.2 2014/05/22 03:48:04 idella4 Exp $

EAPI="5"
# py3.4 support pending
PYTHON_COMPAT=( python{2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="Visual rendering engine for HTML and CSS that can export to PDF"
MY_PN="WeasyPrint"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"
HOMEPAGE="http://weasyprint.org https://github.com/Kozea/WeasyPrint"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

# Note: specific subslot of pango since it inlines some of pango headers.
#cffi>=0.6
RDEPEND="x11-libs/pango:0/0
	>=media-gfx/cairosvg-0.4.1[${PYTHON_USEDEP}]
	>=dev-python/html5lib-0.999[${PYTHON_USEDEP}]
	dev-python/cffi:=[${PYTHON_USEDEP}]
	>=dev-python/lxml-3.0[${PYTHON_USEDEP}]
	>=dev-python/cairocffi-0.5[${PYTHON_USEDEP}]
	~dev-python/tinycss-0.3[${PYTHON_USEDEP}]
	>=dev-python/cssselect-0.6[${PYTHON_USEDEP}]
	>=dev-python/pyphen-0.8[${PYTHON_USEDEP}]"
	# x11-libs/gdk-pixbuf # optional dep
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( ${RDEPEND}
		dev-python/pytest[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	# https://github.com/Kozea/WeasyPrint/issues/195
	sed -e s':test_annotate_document:_&:' -e s':test_units:_&:' \
		-i ${PN}/tests/test_css.py || die
	sed -e 's:test_images:_&:' -i  ${PN}/tests/test_draw.py || die
	sed -e 's:test_vertical_align:_&:' -e s':test_preferred_widths:_&:' \
		-e 's:test_overflow_wrap:_&:' \
		-i ${PN}/tests/test_layout.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	py.test || die "testsuite failed under ${EPYTHON}"
}
