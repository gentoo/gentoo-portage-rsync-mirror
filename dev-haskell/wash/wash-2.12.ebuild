# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/wash/wash-2.12.ebuild,v 1.2 2010/07/12 14:23:37 slyfox Exp $

EAPI=1

CABAL_FEATURES="profile haddock lib bin"
inherit check-reqs eutils haskell-cabal

MY_PN="WashNGo"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="WASH is a family of embedded domain specific languages for programming Web applications in Haskell."
HOMEPAGE="http://www.informatik.uni-freiburg.de/~thiemann/haskell/WASH/"
SRC_URI="http://www.informatik.uni-freiburg.de/~thiemann/haskell/WASH/${MY_P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6
		dev-haskell/parsec:0
		dev-haskell/regex-compat"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	# There are a couple Wash modules which take forever to compile and
	# cause ghc take loads of memory. We try and limit ghc's heap size
	# but it still takes a lot.
	einfo "Some Wash modules take a lot of RAM and a very long time to compile."
	einfo "Please be patient."
	# We need aproximately this much memory: (does *not* check swap)
	case "${ARCH}" in
		alpha|*64) CHECKREQS_MEMORY="600" ;;
		*)         CHECKREQS_MEMORY="300" ;;
	esac
	check_reqs
}

src_unpack() {
	unpack ${A}

	cabal-mksetup
	sed -i -e "/Extensions/aGhc-Options: -O +RTS -M${CHECKREQS_MEMORY}m -RTS" \
		"${S}/WASH.cabal"
	echo "Ghc-Options: -O +RTS -M${CHECKREQS_MEMORY}m -RTS" \
		>> "${S}/WASH.cabal"

	# Add in the extra split-base deps
	if version_is_at_least "6.8" "$(ghc-version)"; then
		sed -i -e '/Build-Depends:/a \
			,containers' \
		"${S}/WASH.cabal"
	fi

	# dislikes parsec-3
	sed -i -e 's/parsec/parsec < 3/' \
		"${S}/WASH.cabal"

	cd "${S}"
	epatch "${FILESDIR}/wash-2.12-ghc-io.patch"

}

src_install() {
	cabal_src_install

	dodoc README
	if use doc; then
		dodoc Examples
	fi
}
