# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/cpuburn/cpuburn-1.4.ebuild,v 1.15 2009/10/12 19:02:05 halcy0n Exp $

MY_P="${PV/./_}"
DESCRIPTION="designed to heavily load CPU chips [testing purposes]"
HOMEPAGE="http://pages.sbcglobal.net/redelm/"
SRC_URI="http://pages.sbcglobal.net/redelm/cpuburn_${MY_P}_tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
RESTRICT="strip"

DEPEND="sys-devel/gcc"
RDEPEND="amd64? ( >=app-emulation/emul-linux-x86-baselibs-1.0 )"

src_unpack() {
	# for some reason he has it _tar instead of .tar ...
	unpack ${A}
	tar -xf cpuburn_${MY_P}_tar || die

	if use amd64 ; then	#65719
		cd "${S}"
		sed -i 's:gcc -s:gcc -m32 -s:' Makefile || die "sed failed"
	fi
}

src_compile() {
	emake || die
}

src_install() {
	dodoc Design README
	dobin burn{BX,K6,K7,MMX,P5,P6} || die
}
