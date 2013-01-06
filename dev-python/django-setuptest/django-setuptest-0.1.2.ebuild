# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-setuptest/django-setuptest-0.1.2.ebuild,v 1.1 2012/11/18 12:24:13 idella4 Exp $

EAPI=4
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"
SUPPORT_PYTHON_ABIS=1
inherit distutils

MY_PN="praekelt-${P}-O-g86Offe9"
MY_P="praekelt-${PN}-860ffe9"
DESCRIPTION="Simple test suite enabling Django app testing via setup.py"
HOMEPAGE="https://github.com/praekelt/django-setuptest"
SRC_URI="https://github.com/praekelt/${PN}/zipball/master/${MY_PN}.zip"
LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pep8
	dev-python/coverage"

DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"
