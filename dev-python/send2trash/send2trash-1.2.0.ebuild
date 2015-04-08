# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/send2trash/send2trash-1.2.0.ebuild,v 1.5 2015/04/08 08:05:23 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 pypy )

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
