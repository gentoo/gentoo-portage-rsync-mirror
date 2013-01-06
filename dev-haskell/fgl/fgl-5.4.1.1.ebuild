# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/fgl/fgl-5.4.1.1.ebuild,v 1.6 2012/09/12 14:38:55 qnikst Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal versionator

DESCRIPTION="A functional graph library for Haskell."
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc sparc x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.4
	dev-haskell/mtl"

src_unpack() {
	unpack ${A}

	if ! version_is_at_least "6.8" "$(ghc-version)"; then
		sed -i -e 's/, containers, array//' "${S}/fgl.cabal"
	fi
}
