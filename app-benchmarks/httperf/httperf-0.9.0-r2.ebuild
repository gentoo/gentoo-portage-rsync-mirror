# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/httperf/httperf-0.9.0-r2.ebuild,v 1.4 2014/08/05 07:59:56 patrick Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1

inherit autotools-utils toolchain-funcs

DESCRIPTION="A tool from HP for measuring web server performance"
HOMEPAGE="http://code.google.com/p/httperf/"
SRC_URI="http://httperf.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips x86 ~amd64-linux ~x64-macos"
IUSE="debug"

DEPEND="dev-libs/openssl"
RDEPEND="dev-libs/openssl"

DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_configure() {
	econf --bindir="${EPREFIX}"/usr/bin \
		$(use_enable debug)
}

src_compile() {
	emake CC="$(tc-getCC)" -j1
}
