# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/agda-stdlib/agda-stdlib-0.6.ebuild,v 1.2 2013/01/10 12:31:25 gienah Exp $

EAPI=4

DESCRIPTION="Agda standard library"
HOMEPAGE="http://wiki.portal.chalmers.se/agda/"
SRC_URI="http://www.cse.chalmers.se/~nad/software/lib-${PV}.tar.gz -> ${P}.tar.gz"

inherit elisp-common

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="profile"

DEPEND="=sci-mathematics/agda-executable-2.3.0*"
RDEPEND="=sci-mathematics/agda-2.3.0*[profile?]"

SITEFILE="50${PN}-gentoo.el"

S="${WORKDIR}/lib-${PV}"

src_compile() {
	local prof
	use profile && prof="--ghc-flag=-prof"
	agda +RTS -K1G -RTS ${prof} \
		-i "${S}" -i "${S}"/src "${S}"/Everything.agda || die
	agda --html -i "${S}" -i "${S}"/src "${S}"/README.agda || die
}

src_test() {
	agda -i "${S}" -i "${S}"/src README.agda || die
}

src_install() {
	insinto usr/share/agda-stdlib
	export INSOPTIONS=--preserve-timestamps
	doins -r src/*
	dodoc -r html/*
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
}
