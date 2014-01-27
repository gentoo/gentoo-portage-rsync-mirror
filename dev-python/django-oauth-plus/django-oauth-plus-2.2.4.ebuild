# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-oauth-plus/django-oauth-plus-2.2.4.ebuild,v 1.1 2014/01/27 02:24:42 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Support of OAuth 1.0a in Django using python-oauth2"
HOMEPAGE="http://pypi.python.org/pypi/django-oauth-plus	http://code.welldev.org/django-oauth-plus/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-python/django-1.3[${PYTHON_USEDEP}]
	>=dev-python/oauth2-1.5.170[${PYTHON_USEDEP}]
	>=dev-python/south-0.7.5[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/setuptools_hg[${PYTHON_USEDEP}]
	test? ( ${RDEPEND} )"

python_test() {
	PYTHONPATH=.:oauth_provider
	if "${PYTHON}" oauth_provider/runtests/runtests.py; then
		einfo "Testsuite passed under ${EPYTHON}"
	else
		die "Testsuite failed under ${EPYTHON}"
	fi
}
