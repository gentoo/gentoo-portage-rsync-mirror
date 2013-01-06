# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/uuagc/uuagc-0.9.5.ebuild,v 1.2 2010/07/12 13:41:29 slyfox Exp $

CABAL_FEATURES="bin"
inherit haskell-cabal

DESCRIPTION="The Utrecht University Attribute Grammar system"
HOMEPAGE="http://www.cs.uu.nl/wiki/HUT/AttributeGrammarSystem"
SRC_URI="http://abaris.zoo.cs.uu.nl:8080/wiki/pub/HUT/Download/${P}-src.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
	dev-haskell/mtl
	>=dev-haskell/uulib-0.9.2"

src_unpack() {
	unpack ${A}

	sed -i -e '/Extensions:/a \
		, MultiParamTypeClasses' \
		"${S}/uuagc.cabal"

	# Add in the extra split-base deps
	if version_is_at_least "6.8" "$(ghc-version)"; then
		sed -i -e '/Build-Depends:/a \
			,containers, directory, array, bytestring' \
			"${S}/uuagc.cabal"
	fi
}
