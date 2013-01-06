# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/reptyr/reptyr-0.4.ebuild,v 1.3 2012/12/04 11:30:29 ago Exp $

EAPI=4

inherit toolchain-funcs flag-o-matic vcs-snapshot

DESCRIPTION="A utility to attach a running program to a new terminal"
HOMEPAGE="https://github.com/nelhage/reptyr"
SRC_URI="https://github.com/nelhage/${PN}/tarball/${P} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm x86 ~amd64-linux ~x86-linux"
IUSE=""

src_compile() {
	append-cflags -D_GNU_SOURCE
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install
	dodoc ChangeLog NOTES README.md
}
