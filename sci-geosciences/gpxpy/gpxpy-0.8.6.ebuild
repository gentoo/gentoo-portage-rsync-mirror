# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gpxpy/gpxpy-0.8.6.ebuild,v 1.3 2014/11/28 14:12:08 pacho Exp $

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 python3_2 python3_3 python3_4 )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="python GPX parser"
HOMEPAGE="https://github.com/tkrajina/gpxpy"
SRC_URI="https://github.com/tkrajina/${PN}/tarball/85c3477b -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS=( NOTICE.txt README.md )

python_test() {
	${PYTHON} -m unittest test
}
