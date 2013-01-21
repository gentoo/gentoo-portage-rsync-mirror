# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/colorama/colorama-0.2.4.ebuild,v 1.1 2013/01/21 08:51:49 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_5 python2_6 python2_7 python3_1 python3_2 )

inherit distutils-r1

DESCRIPTION="Makes ANSI escape character sequences, for producing colored
terminal text and cursor positioning."
HOMEPAGE="http://code.google.com/p/colorama/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""
