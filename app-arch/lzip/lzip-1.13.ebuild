# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lzip/lzip-1.13.ebuild,v 1.7 2012/07/29 17:08:20 armin76 Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="lossless data compressor based on the LZMA algorithm"
HOMEPAGE="http://www.nongnu.org/lzip/lzip.html"
SRC_URI="http://download.savannah.gnu.org/releases-noredirect/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-flags.patch
	tc-export CC CXX
}
