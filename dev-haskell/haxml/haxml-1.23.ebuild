# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/haxml/haxml-1.23.ebuild,v 1.2 2012/09/12 15:20:42 qnikst Exp $

EAPI=4

CABAL_FEATURES="bin lib profile haddock hscolour hoogle"
inherit base haskell-cabal

MY_PN="HaXml"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Utilities for manipulating XML documents"
HOMEPAGE="http://www.cs.york.ac.uk/fp/HaXml/"
SRC_URI="mirror://hackage/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT=0
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-haskell/polyparse-1.5[profile?]
		>=dev-lang/ghc-6.8.2"
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.2"

S="${WORKDIR}/${MY_P}"

PATCHES=("${FILESDIR}/${PN}-1.23-fix-build.patch"
	"${FILESDIR}/${PN}-1.23-haddock.patch")
