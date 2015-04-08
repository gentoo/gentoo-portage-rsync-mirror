# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/datefudge/datefudge-1.14.ebuild,v 1.13 2011/02/22 19:11:12 nixnut Exp $

EAPI=2
inherit multilib toolchain-funcs

DESCRIPTION="A program (and preload library) to fake system date"
HOMEPAGE="http://packages.qa.debian.org/d/datefudge.html"
SRC_URI="mirror://debian/pool/main/d/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

src_prepare() {
	sed -i \
		-e '/dpkg-parsechangelog/d' \
		-e "s:usr/lib:usr/$(get_libdir):" \
		-e 's:$(CC) -o:$(CC) $(LDFLAGS) -o:' \
		Makefile || die
}

src_compile() {
	tc-export CC
	emake VERSION="${PV}" || die
}

src_install() {
	emake DESTDIR="${D}" VERSION="${PV}" install || die
	dodoc debian/changelog README
}
