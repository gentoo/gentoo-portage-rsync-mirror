# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-nose/django-nose-1.2-r1.ebuild,v 1.1 2014/09/21 01:49:09 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="Django test runner that uses nose"
HOMEPAGE="https://github.com/jbalogh/django-nose"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=dev-python/nose-1.0[${PYTHON_USEDEP}]
	<dev-python/django-1.7[${PYTHON_USEDEP}]
	>=dev-python/south-0.7[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" testapp/runtests.py
}
