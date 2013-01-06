# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tinycss/tinycss-0.2.ebuild,v 1.2 2012/06/07 16:54:04 ssuominen Exp $

EAPI=4

PYTHON_DEPEND="2:2.7 3:3.2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="2.5 2.6 3.1"

inherit distutils

DESCRIPTION="A complete yet simple CSS parser for Python"
HOMEPAGE="http://github.com/SimonSapin/tinycss/ http://packages.python.org/tinycss/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/lxml"
DEPEND="${RDEPEND}"

DOCS="CHANGES README.rst"
