# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mccabe/mccabe-0.2.1.ebuild,v 1.5 2014/04/25 14:24:06 jer Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="a plugin for flake8"
HOMEPAGE="https://github.com/flintwork/mccabe"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="amd64 ~hppa x86"
IUSE=""
LICENSE="MIT"
SLOT="0"

RDEPEND=">=dev-python/pep8-1.4.3[${PYTHON_USEDEP}]
	dev-python/flake8[${PYTHON_USEDEP}]"
DEPEND="	dev-python/setuptools[${PYTHON_USEDEP}]"
