# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/genromfs/genromfs-0.5.2.ebuild,v 1.7 2012/10/03 18:08:30 ranger Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Create space-efficient, small, read-only romfs filesystems"
HOMEPAGE="http://romfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 s390 x86"
IUSE=""

DOCS=( ChangeLog NEWS genromfs.lsm genrommkdev readme-kernel-patch romfs.txt )

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	tc-export CC
	default
}
