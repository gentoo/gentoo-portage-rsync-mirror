# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/openpyxl/openpyxl-1.5.8.ebuild,v 1.2 2012/12/03 21:31:10 bicatali Exp $

EAPI=4

# python cruft
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="nosetests"
RESTRICT_PYTHON_ABIS="2.4"

inherit distutils

DESCRIPTION="Pure python reader and writer of Excel OpenXML files"
HOMEPAGE="http://bitbucket.org/ericgazoni/openpyxl/wiki/Home"
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
# fork from https://bitbucket.org/hjunes/openpyxl/ compatible with python3
SRC_URI="http://dev.gentoo.org/~bicatali/distfiles/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
