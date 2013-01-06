# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libbinio/libbinio-1.4.ebuild,v 1.20 2011/12/23 00:48:16 ssuominen Exp $

EAPI=4
inherit eutils

DESCRIPTION="Binary I/O stream class library"
HOMEPAGE="http://libbinio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="static-libs"

DOCS=( AUTHORS NEWS README )

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-cstdio.patch \
		"${FILESDIR}"/${P}-texi.patch
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	rm -f "${ED}"usr/lib*/${PN}.la
}
