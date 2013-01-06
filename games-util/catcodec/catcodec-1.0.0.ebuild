# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/catcodec/catcodec-1.0.0.ebuild,v 1.7 2010/10/15 13:45:59 maekke Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="Decodes and encodes sample catalogues for OpenTTD"
HOMEPAGE="http://www.openttd.org/en/download-catcodec"
SRC_URI="http://binaries.openttd.org/extra/catcodec/${PV}/${P}-source.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
	tc-export CXX
}

src_install() {
	dobin catcodec || die
	dodoc README || die
	doman catcodec.1 || die
}
