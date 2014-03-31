# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-mpd/python-mpd-0.5.1.ebuild,v 1.6 2014/03/31 20:50:55 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy pypy2_0 )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Python MPD client library"
HOMEPAGE="https://github.com/Mic92/python-mpd2"
SRC_URI="https://github.com/Mic92/${PN}2/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
SLOT="0"
IUSE="test"

DEPEND="test? ( virtual/python-unittest2[${PYTHON_USEDEP}]
	dev-python/mock[${PYTHON_USEDEP}] )
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS=( CHANGES.rst PORTING.rst README.rst doc/commands.rst )
PATCHES=( "${FILESDIR}"/${P}-non-unicode-locale.patch )

python_test() {
	"${PYTHON}" test.py || die "Tests fail with ${EPYTHON}"
}
