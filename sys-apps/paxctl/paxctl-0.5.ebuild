# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/paxctl/paxctl-0.5.ebuild,v 1.9 2012/05/24 10:57:33 jlec Exp $

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Manages various PaX related program header flags for Elf32, Elf64, binaries"
SRC_URI="http://pax.grsecurity.net/paxctl-${PV}.tar.gz"
HOMEPAGE="http://pax.grsecurity.net"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=sys-devel/binutils-2.14.90.0.8-r1"
RDEPEND=""

src_compile() {
	tc-export CC
	emake CC="${CC}" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	einstall DESTDIR="${D}"
	dodoc README ChangeLog
}
