# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mozfile/mozfile-0.9.ebuild,v 1.1 2013/07/23 11:44:11 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Library of file utilities for use in Mozilla testing"
HOMEPAGE="https://wiki.mozilla.org/Auto-tools/Projects/Mozbase"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="MPL-2.0"
SLOT="0"

RDEPEND=""
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
