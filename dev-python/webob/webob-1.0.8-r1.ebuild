# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/webob/webob-1.0.8-r1.ebuild,v 1.1 2013/03/25 15:28:35 prometheanfire Exp $

EAPI="5"
PYTHON_COMPAT=( python2_{5,6,7} )

inherit distutils-r1 eutils

MY_PN="WebOb"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="WSGI request and response object"
HOMEPAGE="http://webob.org/ http://pypi.python.org/pypi/WebOb"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc"

DEPEND="app-arch/unzip
	dev-python/setuptools
	doc? ( dev-python/sphinx )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	distutils-r1_python_compile

	if use doc; then
		einfo "Generation of documentation"
		"$(PYTHON -f)" setup.py build_sphinx || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils-r1_python_install

	if use doc; then
		pushd build/sphinx/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _static || die "Installation of documentation failed"
		popd > /dev/null
	fi
}
