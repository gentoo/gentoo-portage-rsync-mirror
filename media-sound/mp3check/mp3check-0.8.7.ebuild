# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3check/mp3check-0.8.7.ebuild,v 1.5 2014/08/10 21:08:22 slyfox Exp $

EAPI=5
inherit flag-o-matic toolchain-funcs

DESCRIPTION="Checks mp3 files for consistency and prints several errors and warnings"
HOMEPAGE="http://code.google.com/p/mp3check/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

src_prepare() {
	sed -i -e '/^WARN/s:-g::' Makefile || die
}

src_configure() {
	# tfiletools.h:59:50: warning: dereferencing type-punned pointer will break
	# strict-aliasing rules [-Wstrict-aliasing]
	append-cxxflags -fno-strict-aliasing
}

src_compile() {
	emake CXX="$(tc-getCXX)" OPT="${CXXFLAGS}"
}

src_install() {
	dobin ${PN}
	doman *.1
}
