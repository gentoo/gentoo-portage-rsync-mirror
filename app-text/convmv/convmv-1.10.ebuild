# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/convmv/convmv-1.10.ebuild,v 1.15 2011/02/06 05:44:18 leio Exp $

inherit eutils

DESCRIPTION="convert filenames to utf8 or any other charset"
HOMEPAGE="http://j3e.de/linux/convmv"
SRC_URI="http://j3e.de/linux/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	einstall DESTDIR="${D}" PREFIX=/usr || die "einstall failed"
	dodoc CREDITS Changes TODO VERSION
}

src_test() {
	unpack ./testsuite.tar
	# Never make assumptions as to the ordering of files inside a directory!
	epatch "${FILESDIR}"/${PN}-1.10-testcase-cleanup.patch
	cd "${S}"/suite
	./dotests.sh || die "Tests failed"
}
