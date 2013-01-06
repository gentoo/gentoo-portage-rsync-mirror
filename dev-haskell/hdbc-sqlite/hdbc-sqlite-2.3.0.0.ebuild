# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hdbc-sqlite/hdbc-sqlite-2.3.0.0.ebuild,v 1.3 2012/12/07 10:35:19 slyfox Exp $

CABAL_FEATURES="bin lib profile haddock hscolour"
inherit haskell-cabal

MY_PN="HDBC-sqlite3"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Sqlite v3 driver for HDBC"
HOMEPAGE="http://software.complete.org/hdbc-sqlite3"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test" # not all files are bundled

RDEPEND=">=dev-lang/ghc-6.10
		>=dev-haskell/hdbc-2.2
		dev-haskell/mtl
		dev-haskell/utf8-string
		>=dev-db/sqlite-3.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2.3
		test? ( dev-haskell/convertible
			dev-haskell/hunit
			dev-haskell/testpack
		)
	"

S="${WORKDIR}/${MY_P}"

src_configure() {
	cabal_src_configure $(cabal_flag test buildtests)
}

src_test() {
	# default tests
	haskell-cabal_src_test || die "cabal test failed"

	# built custom tests
	"${S}/dist/build/runtests/runtests" || die "unit tests failed"
}

src_install() {
	cabal_src_install

	# if tests were enabled, make sure the unit test driver is deleted
	rm -f "${ED}/usr/bin/runtests"
}
