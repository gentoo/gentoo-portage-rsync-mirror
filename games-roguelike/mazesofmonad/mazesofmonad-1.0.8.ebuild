# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/mazesofmonad/mazesofmonad-1.0.8.ebuild,v 1.1 2014/09/02 22:23:27 hasufell Exp $

EAPI=5

CABAL_FEATURES="bin"
inherit haskell-cabal games

MY_PN=MazesOfMonad
MY_P=${MY_PN}-${PV}

DESCRIPTION="Console-based roguelike Role Playing Game similar to nethack"
HOMEPAGE="https://github.com/JPMoresmau/MazesOfMonad
	http://hackage.haskell.org/package/MazesOfMonad"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-7.4.1:="
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.6
	dev-haskell/hunit
	dev-haskell/mtl
	dev-haskell/random
	dev-haskell/regex-posix"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	games_pkg_setup
	haskell-cabal_pkg_setup
}

src_configure() {
	haskell-cabal_src_configure \
		--prefix="${GAMES_PREFIX}"
}

src_compile() {
	haskell-cabal_src_compile
}

src_install() {
	haskell-cabal_src_install
	prepgamesdirs
}
