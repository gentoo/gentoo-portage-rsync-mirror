# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/setuptools-git/setuptools-git-1.0_beta1.ebuild,v 1.4 2015/04/08 08:05:07 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_3 )

inherit distutils-r1 versionator

MY_P=${P/_beta/b}
DESCRIPTION="Setuptools revision control system plugin for Git"
HOMEPAGE="https://github.com/wichert/setuptools-git"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"
S=${WORKDIR}/${MY_P}

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""
