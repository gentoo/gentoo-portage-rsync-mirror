# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/webhelpers/webhelpers-1.3.ebuild,v 1.1 2011/03/24 16:13:15 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="WebHelpers"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Web Helpers"
HOMEPAGE="http://webhelpers.groovie.org/ http://pypi.python.org/pypi/WebHelpers"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc"

RDEPEND=">=dev-python/markupsafe-0.9.2
	dev-python/routes"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/sphinx )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare

	# https://bitbucket.org/bbangert/webhelpers/issue/67
	sed \
		-e '/import datetime/a import os' \
		-e 's:"/tmp/feed":os.environ.get("TMPDIR", "/tmp") + "/feed":' \
		-i tests/test_feedgenerator.py || die "sed failed"
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

src_install() {
	distutils_src_install

	if use doc; then
		pushd docs/_build/html > /dev/null
		docinto html
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static || die "Installation of documentation failed"
		popd > /dev/null
	fi
}
