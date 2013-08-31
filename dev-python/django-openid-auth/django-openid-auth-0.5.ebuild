# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-openid-auth/django-openid-auth-0.5.ebuild,v 1.1 2013/08/31 15:54:29 ercpe Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="A library that can be used to add OpenID support to Django applications"
HOMEPAGE="https://launchpad.net/django-openid-auth"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${PN}-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-python/django-1.3[${PYTHON_USEDEP}]
	>=dev-python/python-openid-2.2.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

EXAMPLES=( example_consumer/ )
