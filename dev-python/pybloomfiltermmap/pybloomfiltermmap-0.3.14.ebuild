# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pybloomfiltermmap/pybloomfiltermmap-0.3.14.ebuild,v 1.1 2014/05/07 05:46:00 patrick Exp $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="A Bloom filter (bloomfilter) for Python built on mmap"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
HOMEPAGE="http://pypi.python.org/pypi/pybloomfiltermmap"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
