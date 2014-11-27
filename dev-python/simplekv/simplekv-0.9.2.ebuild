# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/simplekv/simplekv-0.9.2.ebuild,v 1.1 2014/11/27 14:36:48 aballier Exp $

EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A key-value storage for binary data, support many backends."
HOMEPAGE="https://pypi.python.org/pypi/simplekv/ https://github.com/mbr/simplekv"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""
