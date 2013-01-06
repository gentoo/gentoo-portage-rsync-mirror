# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/pysam/pysam-0.6.ebuild,v 1.2 2012/02/25 02:56:39 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.5 2.7-pypy-* *-jython"

inherit distutils

DESCRIPTION="Python interface for the SAM/BAM sequence alignment and mapping format"
HOMEPAGE="http://code.google.com/p/${PN} http://pypi.python.org/pypi/${PN}"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
