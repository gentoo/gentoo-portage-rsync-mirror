# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-social-auth/django-social-auth-0.7.28.ebuild,v 1.3 2015/03/08 23:45:27 pacho Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="An easy to setup social authentication/authorization mechanism for Django projects"
HOMEPAGE="http://pypi.python.org/pypi/django-social-auth/"
SRC_URI="https://github.com/omab/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64 x86"
IUSE="doc examples"

LICENSE="BSD"
SLOT="0"
# Tests access and test logins to social media sites
RESTRICT="test"

RDEPEND=">=dev-python/django-1.2.5[${PYTHON_USEDEP}]
	>=dev-python/oauth2-1.5.167[${PYTHON_USEDEP}]
	>=dev-python/python-openid-2.2[${PYTHON_USEDEP}]
	>=dev-python/selenium-2.29.0[${PYTHON_USEDEP}]
	~dev-python/mock-1.0.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Prevent un-needed d'loading in doc build
	sed -e 's:^intersphinx:_&:' -i doc/conf.py || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && emake -C doc html
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/_build/html/. )
	use examples && local EXAMPLES=( example/. )
	distutils-r1_python_install_all
}
