# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rman/rman-3.2-r1.ebuild,v 1.9 2015/03/31 07:45:07 ago Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="PolyGlotMan man page translator AKA RosettaMan"
HOMEPAGE="http://sourceforge.net/projects/polyglotman/"
SRC_URI="mirror://sourceforge/polyglotman/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RESTRICT="test"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gentoo.diff \
		"${FILESDIR}"/${P}-ldflags.patch \
		"${FILESDIR}"/${P}-format-security.patch
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}"
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
}
