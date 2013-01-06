# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-oauth-plus/django-oauth-plus-2.0.ebuild,v 1.1 2012/05/08 12:16:31 iksaif Exp $

EAPI="4"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Support of OAuth 1.0a in Django using python-oauth2"
HOMEPAGE="http://pypi.python.org/pypi/django-oauth-plus	http://code.welldev.org/django-oauth-plus/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND=">=dev-python/django-1.2.4
	>=dev-python/oauth2-1.5.170"
DEPEND="${RDEPEND}
	dev-python/setuptools
	dev-python/setuptools_hg"

PYTHON_MODNAME="oauth_provider"

src_install() {
	distutils_src_install

	delete_examples() {
		rm -fr "${ED}$(python_get_sitedir)/examples"
	}
	python_execute_function -q delete_examples

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/*
	fi
}
