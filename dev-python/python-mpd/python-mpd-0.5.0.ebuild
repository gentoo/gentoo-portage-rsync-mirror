# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-mpd/python-mpd-0.5.0.ebuild,v 1.1 2013/01/19 21:47:52 angelos Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} pypy{1_9,2_0} )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Python MPD client library"
HOMEPAGE="https://github.com/Mic92/python-mpd2"
SRC_URI="https://github.com/Mic92/${PN}2/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="LGPL-3"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
SLOT="0"
IUSE="test"

DEPEND="test? ( virtual/python-unittest2[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}] )"

DOCS=( CHANGES.rst PORTING.rst README.rst doc/commands.txt )

python_test() {
	"${PYTHON}" test.py || die "Tests fail with ${EPYTHON}"
}
