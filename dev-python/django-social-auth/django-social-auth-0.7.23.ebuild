# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-social-auth/django-social-auth-0.7.23.ebuild,v 1.2 2013/06/01 17:24:37 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="An easy to setup social authentication/authorization mechanism for Django projects"
HOMEPAGE="http://pypi.python.org/pypi/django-social-auth/"
SRC_URI="https://github.com/omab/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE=""

LICENSE="BSD"
SLOT="0"
# Tests access and test logins to social media sites
RESTRICT="test"

RDEPEND=">=dev-python/django-1.3.2[${PYTHON_USEDEP}]
	>=dev-python/oauth2-1.5.170[${PYTHON_USEDEP}]
	>=dev-python/python-openid-2.2[${PYTHON_USEDEP}]
	>=dev-python/selenium-2.29.0[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
