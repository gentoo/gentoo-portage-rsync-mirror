# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udftools/udftools-1.0.0b-r9.ebuild,v 1.7 2012/04/14 08:07:06 zmedico Exp $

EAPI="2"

inherit eutils

MY_P=${P}3

DESCRIPTION="Ben Fennema's tools for packet writing and the UDF filesystem"
HOMEPAGE="http://sourceforge.net/projects/linux-udf/"
SRC_URI="mirror://sourceforge/linux-udf/${MY_P}.tar.gz
	http://w1.894.telia.com/~u89404340/patches/packet/${MY_P}.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="sys-libs/readline"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# For new kernel packet writing driver
	epatch "${WORKDIR}"/${MY_P}.patch
	epatch "${FILESDIR}"/cdrwtool-linux2.6-fix-v2.patch
	epatch "${FILESDIR}"/${P}-gcc4.patch #112122
	epatch "${FILESDIR}"/${P}-bigendian.patch #120245
	epatch "${FILESDIR}"/${P}-openflags.patch #232100
	epatch "${FILESDIR}"/${P}-limits_h.patch
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog
	newinitd "${FILESDIR}"/pktcdvd.init pktcdvd
	dosym /usr/bin/udffsck /usr/sbin/fsck.udf
}
