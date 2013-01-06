# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask-openid/flask-openid-1.0.1.ebuild,v 1.3 2011/10/08 17:46:15 floppym Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils

MY_PN="Flask-OpenID"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="OpenID support for Flask"
HOMEPAGE="http://pypi.python.org/pypi/Flask-OpenID"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND=">=dev-python/flask-0.3
	>=dev-python/python-openid-2.0"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="flaskext/openid.py"

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		cd docs
		PYTHONPATH=".." emake html || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/_build/html/* || die "Installation of documentation failed"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r example || die "Installation of examples failed"
	fi
}
