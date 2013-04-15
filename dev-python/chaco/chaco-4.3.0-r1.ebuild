# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/chaco/chaco-4.3.0-r1.ebuild,v 1.2 2013/04/15 15:12:42 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 virtualx

DESCRIPTION="Enthought Tool Suite: Interactive plotting toolkit"
HOMEPAGE="http://code.enthought.com/projects/chaco/ http://pypi.python.org/pypi/chaco"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples test"

RDEPEND=">=dev-python/enable-4
	dev-python/numpy[${PYTHON_USEDEP}]
	>=dev-python/traitsui-4[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? (
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
		!prefix? ( x11-base/xorg-server[xvfb] )
		x11-apps/xhost
		dev-python/sphinx[${PYTHON_USEDEP}]
	)
	test? (
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
	)"

DOCS=( docs/{Chaco_2_Design.pdf,datamodel_hierarchy.txt,datamodel.pdf,scipy08_tutorial.pdf} )

python_compile_all() {
	use doc && virtualmake -C docs html
}

# Let's unclutter test phase. Tests need to be within "${BUILD_DIR}"/lib for paths to be read correctly
copy_tests() {
	cd "${BUILD_DIR}"/lib || die
	mkdir -p ${PN}/{shell,scales} || die
	cp -a "${S}"/${PN}/tests/ ${PN}/ || die
	cp -a "${S}"/${PN}/shell/tests/ ${PN}/shell/ || die
	cp -a "${S}"/${PN}/scales/tests/ ${PN}/scales/ || die
}

python_test() {
	# skirt tests until fixed; https://github.com/enthought/chaco/issues/112
	copy_tests || die
	VIRTUALX_COMMAND="nosetests" virtualmake -e 'test_estimate_default_scale*' \
		-e 'test_tfrac_hours_04*' -e 'test_tfrac_hours_05*' \
		-e 'test_microsecond*' -I 'border_test_case*'
	rm -rf ${PN}/tests/ /${PN}/shell/ ${PN}/scales/ || die
}

python_install_all() {
	distutils-r1_python_install_all
	use doc && dohtml -r docs/build/html/

	if use examples; then
		docompress -x usr/share/doc/${PF}/examples/
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
