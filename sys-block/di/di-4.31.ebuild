# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/di/di-4.31.ebuild,v 1.6 2012/05/23 00:31:01 jdhore Exp $

EAPI=4

inherit toolchain-funcs eutils

DESCRIPTION="Disk Information Utility"
HOMEPAGE="http://www.gentoo.com/di/"
SRC_URI="http://www.gentoo.com/di/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-mkdir.patch
}

src_compile() {
	emake prefix=/usr CC="$(tc-getCC)"
}

src_install() {
	emake install prefix="${D}/usr"
	# default symlink is broken
	dosym di /usr/bin/mi
	dodoc README
}
