# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pybloomfiltermmap/pybloomfiltermmap-0.3.11.ebuild,v 1.3 2013/02/17 17:37:24 ago Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.* 2.7-pypy-* *-jython"

inherit distutils

DESCRIPTION="A Bloom filter (bloomfilter) for Python built on mmap"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
HOMEPAGE="http://pypi.python.org/pypi/pybloomfiltermmap"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
