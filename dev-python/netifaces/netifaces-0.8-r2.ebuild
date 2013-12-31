# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/netifaces/netifaces-0.8-r2.ebuild,v 1.1 2013/12/28 22:32:10 xmw Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Portable network interface information"
HOMEPAGE="http://alastairs-place.net/netifaces/"
SRC_URI="http://alastairs-place.net/projects/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""

PATCHES=( "${FILESDIR}"/${P}-remove-osx-fix.patch )
