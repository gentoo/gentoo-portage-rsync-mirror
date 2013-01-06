# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/quickcheck/quickcheck-2.1.0.3.ebuild,v 1.9 2012/09/12 15:10:42 qnikst Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN="QuickCheck"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Automatic testing of Haskell programs"
HOMEPAGE="http://www.cs.chalmers.se/~koen"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="2"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-lang/ghc-6.10
		>=dev-haskell/cabal-1.2
		dev-haskell/mtl"

# would work with ghc 6.8 (6.6 too?) too if we added this dep
# dev-haskell/extensible-exceptions. however, we'd prefer not to add more core
# packages, as we don't want them upgradeable (leads to trouble).
#
# this means that we can only support the architectures which has >=ghc-6.10
# and unfortunately have to drop the others until we get proper ghc support :(

S="${WORKDIR}/${MY_P}"
