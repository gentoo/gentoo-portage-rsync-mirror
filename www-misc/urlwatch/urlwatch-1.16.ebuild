# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/urlwatch/urlwatch-1.16.ebuild,v 1.1 2014/02/04 04:00:18 radhermit Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1

DESCRIPTION="A tool for monitoring webpages for updates"
HOMEPAGE="http://thp.io/2008/urlwatch/ http://pypi.python.org/pypi/urlwatch"
SRC_URI="http://thp.io/2008/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/python-futures"
RDEPEND="${DEPEND}
	|| ( www-client/lynx app-text/html2text )"

python_prepare() {
	if [[ ${EPYTHON} == python3.* ]]; then
		2to3 -nw --no-diffs urlwatch lib/urlwatch/*.py \
			share/urlwatch/examples/hooks.py.example setup.py || die
	fi
}
