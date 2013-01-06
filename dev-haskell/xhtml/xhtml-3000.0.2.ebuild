# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/xhtml/xhtml-3000.0.2.ebuild,v 1.9 2008/07/15 06:10:43 jer Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

GHC_PV=6.6.1

DESCRIPTION="XHTML combinator library for haskell"
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI="http://www.haskell.org/ghc/dist/${GHC_PV}/ghc-${GHC_PV}-src-extralibs.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc sparc x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6"

S="${WORKDIR}/ghc-${GHC_PV}/libraries/${PN}"

src_unpack() {
	unpack ${A}
	cabal-mksetup
}
