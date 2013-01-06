# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/cgi/cgi-3001.1.5.1.ebuild,v 1.5 2012/09/12 14:37:53 qnikst Exp $

CABAL_FEATURES="lib profile haddock"
CABAL_MIN_VERSION=1.2
inherit haskell-cabal

DESCRIPTION="A library for writing CGI programs"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/cgi"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
		>=dev-haskell/network-2.0
		>=dev-haskell/mtl-1.0
		>=dev-haskell/xhtml-3000.0.0
		>=dev-haskell/parsec-2.0"

CABAL_CONFIGURE_FLAGS="--constraint=base<4"
