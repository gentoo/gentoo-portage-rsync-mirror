# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-oauth-plus/django-oauth-plus-2.1.0.ebuild,v 1.1 2013/04/04 07:30:01 patrick Exp $

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
IUSE=""

RDEPEND=">=dev-python/django-1.2.4
	>=dev-python/oauth2-1.5.170"
DEPEND="${RDEPEND}
	dev-python/setuptools
	dev-python/setuptools_hg"

PYTHON_MODNAME="oauth_provider"
