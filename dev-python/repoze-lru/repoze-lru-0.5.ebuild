# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/repoze-lru/repoze-lru-0.5.ebuild,v 1.3 2012/05/25 22:08:16 floppym Exp $

EAPI=3

PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS=1
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN=${PN/-/.}
MY_P=${MY_PN}-${PV}

DESCRIPTION="A tiny LRU cache implementation and decorator"
HOMEPAGE="http://www.repoze.org"
SRC_URI="mirror://pypi/${P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${MY_P}
