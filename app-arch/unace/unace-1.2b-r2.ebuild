# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unace/unace-1.2b-r2.ebuild,v 1.1 2013/03/28 03:07:37 vapier Exp $

EAPI="4"

inherit eutils toolchain-funcs

DEB_VER="10"
DESCRIPTION="ACE unarchiver"
HOMEPAGE="http://www.winace.com/"
SRC_URI="mirror://debian/pool/main/u/${PN}/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/u/${PN}/${PN}_${PV}-${DEB_VER}.debian.tar.gz"

LICENSE="GPL-2" #92846
SLOT="1"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~s390 ~x86"
IUSE=""

S=${WORKDIR}/${PN}${PV}

src_prepare() {
	epatch $(sed 's:^:../debian/patches/:' "${WORKDIR}"/debian/patches/series)
	epatch "${FILESDIR}"/${P}-64bit-fmt.patch
	epatch "${FILESDIR}"/${P}-aliasing.patch
	cp unix/{makefile,gccmaked} . || die
}

src_configure() {
	sed -i \
		-e '/^OSTYPE =/s:=.*:= Linux:' \
		-e "/^CFLAGS =/s:=.*:+= -Wall:" \
		-e "/^CC =/s:=.*:= $(tc-getCC):" \
		-e 's/-DCASEINSENSE//g' \
		makefile || die
}

src_compile() {
	emake dep
	emake
}

src_install() {
	dobin unace
	dodoc unix/readme.txt changes.log
	doman ../debian/unace.1
}
