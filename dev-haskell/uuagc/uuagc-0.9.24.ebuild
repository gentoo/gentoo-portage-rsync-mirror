# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/uuagc/uuagc-0.9.24.ebuild,v 1.5 2012/09/12 15:24:31 qnikst Exp $

CABAL_FEATURES="bin lib profile haddock"
inherit haskell-cabal

DESCRIPTION="Attribute Grammar System of Universiteit Utrecht"
HOMEPAGE="http://www.cs.uu.nl/wiki/HUT/WebHome"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

HASKELLDEPS="dev-haskell/cabal
		>=dev-haskell/uulib-0.9.12"
RDEPEND=">=dev-lang/ghc-6.10
		${HASKELLDEPS}"
DEPEND=">=dev-haskell/cabal-1.2
		${RDEPEND}"
