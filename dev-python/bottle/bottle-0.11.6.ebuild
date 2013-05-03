# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bottle/bottle-0.11.6.ebuild,v 1.2 2013/05/03 20:34:08 pinkbyte Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy{1_8,1_9,2_0})
inherit distutils-r1 python-r1

DESCRIPTION="A fast and simple micro-framework for small web-applications"
HOMEPAGE="http://pypi.python.org/pypi/bottle http://bottlepy.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
