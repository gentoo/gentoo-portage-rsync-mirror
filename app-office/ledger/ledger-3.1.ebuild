# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/ledger/ledger-3.1.ebuild,v 1.2 2015/01/13 21:34:51 yac Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="A double-entry accounting system with a command-line reporting interface"
HOMEPAGE="http://ledger-cli.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.zip -> ${P}.zip"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND="dev-libs/boost
	dev-libs/gmp
	dev-libs/mpfr
"
RDEPEND="${DEPEND}"

DOCS=(README.md)
