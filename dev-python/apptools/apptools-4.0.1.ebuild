# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/apptools/apptools-4.0.1.ebuild,v 1.5 2012/09/15 19:49:17 xarthisius Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils virtualx eutils

DESCRIPTION="Enthought Tool Suite: Application tools"
HOMEPAGE="http://code.enthought.com/projects/app_tools/ http://pypi.python.org/pypi/apptools"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND="dev-python/configobj
	dev-python/numpy
	>=dev-python/traits-4"
DEPEND="dev-python/setuptools
	doc? ( dev-python/sphinx )
	test? (
		${RDEPEND}
		>=dev-python/pyface-4
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
		sci-visualization/mayavi
	)"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}"/${PN}_test.patch
}

src_compile() {
	distutils_src_compile
	use doc && emake -C docs html
}

src_test() {
	VIRTUALX_COMMAND="python_execute_nosetests" \
		virtualmake -P '${S}/build-${PYTHON_ABI}/lib:${S}'
}

src_install() {
	find -name "*LICENSE*.txt" -delete
	distutils_src_install

	use doc && dohtml -r docs/build/html/*

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
