# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/minimock/minimock-1.2.8-r1.ebuild,v 1.4 2013/07/23 20:02:31 ago Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

MY_PN="MiniMock"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="The simplest possible mock library"
HOMEPAGE="http://pypi.python.org/pypi/MiniMock"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm ppc ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

DOCS=( docs/changelog.rst docs/index.rst )
