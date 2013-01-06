# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/uuagc/uuagc-0.9.1.ebuild,v 1.13 2011/12/18 12:39:59 slyfox Exp $

EAPI="4"

CABAL_FEATURES="bin"
inherit base haskell-cabal

DESCRIPTION="The Utrecht University Attribute Grammar system"
HOMEPAGE="http://www.cs.uu.nl/wiki/HUT/AttributeGrammarSystem"
SRC_URI="http://abaris.zoo.cs.uu.nl:8080/wiki/pub/HUT/Download/${P}-src.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.2.2
		>=dev-haskell/uulib-0.9.1"
RDEPEND=""

PATCHES=("${FILESDIR}"/${PN}-0.9.1-split-base.patch)
