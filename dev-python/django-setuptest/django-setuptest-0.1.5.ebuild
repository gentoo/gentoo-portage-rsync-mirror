# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-setuptest/django-setuptest-0.1.5.ebuild,v 1.1 2014/09/17 13:22:35 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="Simple test suite enabling Django app testing via setup.py"
HOMEPAGE="https://github.com/praekelt/django-setuptest"
SRC_URI="https://github.com/praekelt/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pep8[${PYTHON_USEDEP}]
	dev-python/coverage[${PYTHON_USEDEP}]
	dev-python/django[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
