# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ksymoops/ksymoops-2.4.11-r1.ebuild,v 1.5 2012/06/14 07:58:28 xmw Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Utility to decode a kernel oops, or other kernel call traces"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/ksymoops/"
SRC_URI="ftp://ftp.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~mips ppc s390 sparc x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${P}-fortify-fix.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dobin ksymoops || die
	doman ksymoops.8
	dodoc Changelog README README.XFree86
}
