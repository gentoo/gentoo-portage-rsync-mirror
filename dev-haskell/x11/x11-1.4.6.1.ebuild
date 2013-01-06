# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/x11/x11-1.4.6.1.ebuild,v 1.8 2012/09/12 14:44:14 qnikst Exp $

CABAL_FEATURES="lib profile haddock"
inherit haskell-cabal eutils

MY_PN="X11"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A binding to the X11 graphics library"
HOMEPAGE="http://darcs.haskell.org/X11"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="xinerama"

RDEPEND=">=dev-lang/ghc-6.8
		x11-libs/libX11
		xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"

S="${WORKDIR}/${MY_P}"

src_compile() {
	CABAL_CONFIGURE_FLAGS="--configure-option=$(use_with xinerama)"
	cabal_src_compile
}
