# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/setuptools-git/setuptools-git-1.0_beta1.ebuild,v 1.2 2013/09/05 18:47:13 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 python3_2 python3_3 )

inherit distutils-r1 versionator

MY_P=${P/_beta/b}
DESCRIPTION="Setuptools revision control system plugin for Git."
HOMEPAGE="https://github.com/wichert/setuptools-git"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"
S=${WORKDIR}/${MY_P}

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""
