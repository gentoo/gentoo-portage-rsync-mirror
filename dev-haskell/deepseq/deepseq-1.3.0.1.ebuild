# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/deepseq/deepseq-1.3.0.1.ebuild,v 1.3 2013/04/03 10:21:59 gienah Exp $

EAPI=5

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

MY_P="${P/_pre*/}"

DESCRIPTION="Deep evaluation of data structures"
HOMEPAGE="http://hackage.haskell.org/package/deepseq"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS=""
IUSE=""

RDEPEND=">=dev-lang/ghc-6.10.4:="
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"

S="${WORKDIR}/${MY_P}"

CABAL_CORE_LIB_GHC_PV="7.6.* 7.7.20121101 7.7.20121213"
