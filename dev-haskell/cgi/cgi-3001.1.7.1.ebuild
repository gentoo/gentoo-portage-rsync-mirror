# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/cgi/cgi-3001.1.7.1.ebuild,v 1.6 2012/09/12 14:37:53 qnikst Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

DESCRIPTION="A library for writing CGI programs"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/cgi"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/mtl-1.0
		>=dev-haskell/network-2.0
		>=dev-haskell/parsec-2.0
		>=dev-haskell/xhtml-3000.0.0"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"
