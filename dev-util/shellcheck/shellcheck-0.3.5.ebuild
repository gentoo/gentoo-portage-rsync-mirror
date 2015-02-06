# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/shellcheck/shellcheck-0.3.5.ebuild,v 1.1 2015/02/06 14:25:53 jlec Exp $

EAPI=5

CABAL_FEATURES="bin"

inherit haskell-cabal

DESCRIPTION="a static analysis tool for shell scripts"
HOMEPAGE="http://www.shellcheck.net"
SRC_URI="https://github.com/koalaman/shellcheck/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="AGPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-haskell/json
	dev-haskell/mtl
	dev-haskell/parsec
	dev-haskell/regex-compat
	dev-haskell/quickcheck:2
"
