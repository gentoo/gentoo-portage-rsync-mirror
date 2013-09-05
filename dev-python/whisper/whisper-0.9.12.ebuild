# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/whisper/whisper-0.9.12.ebuild,v 1.2 2013/09/05 18:47:00 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Fixed size round-robin style database"
HOMEPAGE="http://graphite.wikidot.com/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""
