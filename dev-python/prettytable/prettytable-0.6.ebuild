# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/prettytable/prettytable-0.6.ebuild,v 1.1 2012/10/18 13:04:13 zx2c4 Exp $

EAPI=4

PYTHON_DEPEND="2:2.6 3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A Python library for easily displaying tabular data in a
visually appealing ASCII table format."
HOMEPAGE="https://code.google.com/p/prettytable/"
SRC_URI="https://prettytable.googlecode.com/files/prettytable-0.6.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}"
