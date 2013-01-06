# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pastescript/pastescript-1.7.5-r1.ebuild,v 1.1 2012/11/17 19:19:20 floppym Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
#DISTUTILS_SRC_TEST="nosetests"

inherit distutils eutils

MY_PN="PasteScript"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A pluggable command-line frontend, including commands to setup package file layouts"
HOMEPAGE="http://pythonpaste.org/script/ http://pypi.python.org/pypi/PasteScript"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc"

RDEPEND="dev-python/cheetah
	>=dev-python/paste-1.3
	dev-python/pastedeploy
	dev-python/setuptools"
DEPEND="${RDEPEND}
	doc? ( dev-python/pygments dev-python/sphinx )"

# Tests are broken.
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="paste/script"

src_prepare() {
	epatch "${FILESDIR}/${PN}-setup.py-exclude-tests.patch"
	distutils_src_prepare
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		PYTHONPATH="." "$(PYTHON -f)" setup.py build_sphinx || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		pushd build/sphinx/html > /dev/null
		docinto html
		cp -R [a-z]* _static "${ED}usr/share/doc/${PF}/html" || die "Installation of documentation failed"
		popd > /dev/null
	fi
}
