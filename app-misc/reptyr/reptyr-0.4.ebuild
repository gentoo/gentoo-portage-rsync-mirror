# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/reptyr/reptyr-0.4.ebuild,v 1.4 2013/05/29 02:01:47 radhermit Exp $

EAPI=4

inherit toolchain-funcs flag-o-matic vcs-snapshot

DESCRIPTION="A utility to attach a running program to a new terminal"
HOMEPAGE="https://github.com/nelhage/reptyr"
SRC_URI="https://github.com/nelhage/${PN}/tarball/${P} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm x86 ~amd64-linux ~x86-linux"
IUSE=""

src_prepare() {
	# respect CFLAGS
	sed -i '/^override/d' Makefile || die
}

src_compile() {
	append-cppflags -D_GNU_SOURCE
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install
	dodoc ChangeLog NOTES README.md
}
