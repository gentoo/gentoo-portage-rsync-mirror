# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/regex-base/regex-base-0.71.ebuild,v 1.3 2012/09/12 15:38:10 qnikst Exp $

CABAL_FEATURES="profile haddock lib"
inherit eutils haskell-cabal

DESCRIPTION="Replaces/Enhances Text.Regex"
HOMEPAGE="http://sourceforge.net/projects/lazy-regex"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6"

CABAL_CORE_LIB_GHC_PV="6.6"
