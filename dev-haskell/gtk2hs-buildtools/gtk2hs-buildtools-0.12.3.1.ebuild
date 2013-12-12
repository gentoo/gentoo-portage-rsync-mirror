# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/gtk2hs-buildtools/gtk2hs-buildtools-0.12.3.1.ebuild,v 1.7 2013/12/12 06:05:04 gienah Exp $

EAPI=4

CABAL_FEATURES="bin"
inherit base haskell-cabal

DESCRIPTION="Tools to build the Gtk2Hs suite of User Interface libraries."
HOMEPAGE="http://projects.haskell.org/gtk2hs/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
		dev-haskell/alex
		>=dev-haskell/cabal-1.8
		dev-haskell/happy
		dev-haskell/random
		>=dev-lang/ghc-6.10.1"

PATCHES=("${FILESDIR}"/${PN}-0.12.3-workaround-UName.patch
	"${FILESDIR}"/${PN}-0.12.3.1-ghc-7.5.patch
)

src_prepare() {
	base_src_prepare
	# c2hs ignores #if __GLASGOW_HASKELL__ >= 704
	if has_version ">=dev-lang/ghc-7.6.1"; then
		epatch "${FILESDIR}"/${PN}-0.12.3.1-remove-conditional-compilation-as-it-is-ignored-ghc-7.6.patch
	fi
}
