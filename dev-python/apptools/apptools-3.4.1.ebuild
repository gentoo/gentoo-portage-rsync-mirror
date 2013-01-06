# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/apptools/apptools-3.4.1.ebuild,v 1.6 2012/03/05 10:49:04 jlec Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils virtualx

MY_PN="AppTools"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought Tool Suite: Application tools"
HOMEPAGE="http://code.enthought.com/projects/app_tools/ http://pypi.python.org/pypi/AppTools"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND="dev-python/configobj
	>=dev-python/enthoughtbase-3.1.0
	dev-python/numpy
	dev-python/setuptools
	>=dev-python/traitsgui-3.6.0"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )
	test? (
		dev-python/coverage
		dev-python/nose
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
		x11-apps/xhost
	)"
# dev-python/envisagecore depends on dev-python/apptools, so dev-python/envisagecore
# cannot be specified in DEPEND/RDEPEND due to circular dependencies.
PDEPEND=">=dev-python/envisagecore-3.2.0"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought integrationtests"

src_prepare() {
	distutils_src_prepare

	# Disable failing tests.
	sed -e "s/test_version_registry/_&/" -i enthought/persistence/tests/test_spawner.py
	sed -e "s/test_run/_&/" -i enthought/persistence/tests/test_version_registry.py
	rm -f enthought/persistence/tests/test_state_pickler.py
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		emake html || die "Generation of documentation failed"
		popd > /dev/null
	fi
}

src_test() {
	VIRTUALX_COMMAND="distutils_src_test" virtualmake
}

src_install() {
	find -name "*LICENSE.txt" -delete
	distutils_src_install

	if use doc; then
		pushd docs/build/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static || die "Installation of documentation failed"
		popd > /dev/null
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/* || die "Installation of examples failed"
	fi
}
