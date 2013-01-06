# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/regex-base/regex-base-0.72.ebuild,v 1.11 2012/09/12 15:38:10 qnikst Exp $

CABAL_FEATURES="profile haddock lib"
inherit eutils haskell-cabal

MY_PV="0.71"
MY_P="regex-base-${MY_PV}"

DESCRIPTION="Replaces/Enhances Text.Regex"
HOMEPAGE="http://sourceforge.net/projects/lazy-regex"
SRC_URI="mirror://hackage/packages/archive/${PN}/${MY_PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc sparc x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6"

CABAL_CORE_LIB_GHC_PV="6.6.1"

src_unpack() {
	unpack ${A}

	# Upgrade us from 0.71 to 0.72 which comes with ghc-6.6.1
	cd "${S}"
	epatch "${FILESDIR}/${PN}-0.71-0.72.patch"
}

S="${WORKDIR}/${MY_P}"
