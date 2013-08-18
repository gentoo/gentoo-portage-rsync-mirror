# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/send2trash/send2trash-1.2.0.ebuild,v 1.3 2013/08/18 13:47:10 ago Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1

MY_PN="Send2Trash"
DESCRIPTION="Sends files to the Trash (or Recycle Bin)"
HOMEPAGE="http://hg.hardcoded.net/send2trash//"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64 x86"
IUSE="doc"
LICENSE="BSD"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}"/${MY_PN}-${PV}
