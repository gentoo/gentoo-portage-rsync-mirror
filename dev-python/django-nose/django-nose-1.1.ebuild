# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-nose/django-nose-1.1.ebuild,v 1.1 2012/05/30 06:19:48 iksaif Exp $

EAPI="4"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Django test runner that uses nose"
HOMEPAGE="https://github.com/jbalogh/django-nose"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=dev-python/nose-1.0
	>=dev-python/django-1.2
	>=dev-python/south-0.7
	dev-python/setuptools"

PYTHON_MODNAME="django_nose"
