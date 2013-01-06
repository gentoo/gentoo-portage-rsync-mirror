# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xmobar/xmobar-0.13.ebuild,v 1.4 2012/12/07 10:41:15 slyfox Exp $

EAPI="3"
CABAL_FEATURES="bin"
inherit base haskell-cabal

DESCRIPTION="A Minimalistic Text Based Status Bar"
HOMEPAGE="http://projects.haskell.org/xmobar/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xft unicode mail alsa"
# wifi USE flag disabled due to compilation error with current stable wireless-tools.
# mpd is disabled as it requires mtl-2 (not in tree)

DEPEND=">=dev-lang/ghc-6.8.1
		>=dev-haskell/cabal-1.6
		dev-haskell/mtl
		dev-haskell/parsec
		dev-haskell/stm
		>=dev-haskell/x11-1.3.0
		unicode? ( dev-haskell/utf8-string )
		xft?  ( dev-haskell/utf8-string
				dev-haskell/x11-xft )
		mail? ( dev-haskell/hinotify )
		alsa? ( >=dev-haskell/alsa-mixer-0.1 )"
#		mpd? ( >=dev-haskell/libmpd-0.5 )
# 		wifi? ( net-wireless/wireless-tools )
#RDEPEND="mpd? ( media-sound/mpd )"
RDEPEND=""

PATCHES=("${FILESDIR}/${PN}-0.13-fix-build-failure-against-ghc-7.2.patch")

src_configure() {
	cabal_src_configure \
		$(cabal_flag xft with_xft) \
		$(cabal_flag unicode with_utf8) \
		$(cabal_flag mail with_inotify) \
		$(cabal_flag alsa with_alsa)
#		$(cabal_flag mpd with_mpd) \
#		$(cabal_flag wifi with_iwlib) \
}

src_install() {
	cabal_src_install

	dodoc samples/xmobar.config README
}
