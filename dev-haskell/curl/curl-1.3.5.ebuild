# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/curl/curl-1.3.5.ebuild,v 1.5 2012/09/12 14:52:41 qnikst Exp $

CABAL_FEATURES="lib profile haddock"
inherit base haskell-cabal

DESCRIPTION="Haskell binding to libcurl"
HOMEPAGE="http://hackage.haskell.org/cgi-bin/hackage-scripts/package/curl"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2
		net-misc/curl"

PATCHES=("${FILESDIR}"/${PN}-1.3.5-ghc-7.patch)
