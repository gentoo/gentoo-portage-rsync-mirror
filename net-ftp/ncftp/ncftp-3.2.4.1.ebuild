# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ncftp/ncftp-3.2.4.1.ebuild,v 1.9 2011/03/01 01:09:57 ranger Exp $

EAPI="2"

inherit eutils toolchain-funcs

IPV6_P="ncftp-323-v6-20091109"
DESCRIPTION="An extremely configurable ftp client"
HOMEPAGE="http://www.ncftp.com/"
SRC_URI="ftp://ftp.${PN}.com/${PN}/${P/.1/}-src.tar.bz2 -> ${P}.tar.bz2"
#	ipv6? ( ftp://ftp.kame.net/pub/kame/misc/${IPV6_P}.diff.gz )"

LICENSE="Clarified-Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~x86-solaris"
IUSE="pch"

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/.1/}"

src_prepare() {
	#use ipv6 && epatch "${DISTDIR}"/${IPV6_P}.diff.gz
	tc-export CC
	sed \
		-e "s:CC=gcc:CC ?= ${CC}:" \
		-e 's:@SFLAG@::' \
		-e 's:@STRIP@:true:' \
		-i Makefile.in */Makefile.in || die
}
src_configure() {
	LC_ALL="C" econf --disable-universal $(use_enable pch precomp ) || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc README.txt doc/*.txt
	dohtml doc/html/*.html
}
