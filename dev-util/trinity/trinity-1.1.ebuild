# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/trinity/trinity-1.1.ebuild,v 1.1 2013/02/07 22:51:32 radhermit Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="A Linux system call fuzz tester"
HOMEPAGE="http://codemonkey.org.uk/projects/trinity/"
SRC_URI="http://codemonkey.org.uk/projects/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_prepare() {
	epatch "${FILESDIR}"/${P}-flags.patch
	tc-export CC
}

src_configure() {
	./configure.sh || die
}

src_install() {
	dobin ${PN}
	dodoc Documentation/* README
}
