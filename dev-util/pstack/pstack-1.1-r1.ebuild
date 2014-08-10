# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pstack/pstack-1.1-r1.ebuild,v 1.3 2014/08/10 21:29:01 slyfox Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Display stack trace of a running process"
SRC_URI="mirror://gentoo/${PN}.tgz"
HOMEPAGE="http://www.linuxcommand.org/man_pages/pstack1.html"
# Old upstream HOMEPAGE: www.whatsis.com/pastack is dead, using
# the man page at the moment.

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -*"
IUSE=""

S=${WORKDIR}/${PN}

src_prepare() {
	# respect CC variable see bug #244036
	sed -i Makefile \
		-e 's:gcc:$(CC) $(CFLAGS) $(LDFLAGS):' \
		|| die "sed Makefile"
	tc-export CC
}

src_install() {
	dosbin pstack || die "dosbin failed"
	doman man1/pstack.1
}
