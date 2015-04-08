# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lzip/lzip-1.15.ebuild,v 1.12 2014/02/25 00:07:16 bicatali Exp $

EAPI="4"

inherit toolchain-funcs

DESCRIPTION="lossless data compressor based on the LZMA algorithm"
HOMEPAGE="http://www.nongnu.org/lzip/lzip.html"
SRC_URI="http://download.savannah.gnu.org/releases-noredirect/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 ppc ppc64 sparc x86 ~amd64-linux ~ppc-macos ~x64-macos ~x86-linux ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

src_configure() {
	# not autotools-based
	./configure \
		--prefix="${EPREFIX}"/usr \
		CXX="$(tc-getCXX)" \
		CPPFLAGS="${CPPFLAGS}" \
		CXXFLAGS="${CXXFLAGS}" \
		LDFLAGS="${LDFLAGS}" || die
}
