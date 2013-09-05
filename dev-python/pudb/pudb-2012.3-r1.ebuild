# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pudb/pudb-2012.3-r1.ebuild,v 1.2 2013/09/05 18:46:00 mgorny Exp $

EAPI="5"

PYTHON_COMPAT=( python2_6 python2_7 python3_2 )

inherit distutils-r1

DESCRIPTION="A full-screen, console-based Python debugger"
HOMEPAGE="http://pypi.python.org/pypi/pudb"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-interix ~x86-linux"
IUSE=""

RDEPEND="dev-python/urwid
	dev-python/pygments"
DEPEND="${RDEPEND}
	dev-python/setuptools"
