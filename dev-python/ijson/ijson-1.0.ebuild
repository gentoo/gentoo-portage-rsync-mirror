# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ijson/ijson-1.0.ebuild,v 1.1 2012/10/28 11:24:17 radhermit Exp $

EAPI="5"
PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Iterative JSON parser with a Pythonic interface"
HOMEPAGE="https://github.com/isagalaev/ijson http://pypi.python.org/pypi/ijson/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/yajl"
DEPEND="${RDEPEND}"
