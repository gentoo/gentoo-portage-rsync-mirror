# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/wxhaskell/wxhaskell-0.12.1.6.ebuild,v 1.3 2012/09/12 15:29:57 qnikst Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal

MY_PN=wx
MY_P=${MY_PN}-${PV}

DESCRIPTION="wxHaskell is a portable and native GUI library for Haskell"
HOMEPAGE="http://haskell.org/haskellwiki/WxHaskell"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-haskell/stm
		>=dev-haskell/wxcore-0.12.1.6
		>=dev-lang/ghc-6.10"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"

S="${WORKDIR}/${MY_P}"
