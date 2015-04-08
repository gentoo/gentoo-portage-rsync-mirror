# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/ledger/ledger-3.1.ebuild,v 1.4 2015/01/19 20:30:38 yac Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="A double-entry accounting system with a command-line reporting interface"
HOMEPAGE="http://ledger-cli.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="dev-libs/boost:=
	dev-libs/gmp
	dev-libs/mpfr
"
DEPEND="${RDEPEND}
	dev-libs/utfcpp
"

DOCS=(README.md)
