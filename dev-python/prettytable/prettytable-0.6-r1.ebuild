# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/prettytable/prettytable-0.6-r1.ebuild,v 1.1 2013/03/21 19:02:26 prometheanfire Exp $

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 python3_2 )

inherit distutils-r1

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
