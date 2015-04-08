# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/amodem/amodem-1.9.ebuild,v 1.1 2015/03/02 23:57:56 blueness Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy pypy3 )

inherit distutils-r1

DESCRIPTION="Transmit data between two computers using audio"
HOMEPAGE="https://github.com/romanz/amodem"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
