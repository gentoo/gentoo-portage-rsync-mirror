# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/archfs/archfs-0.5.6b.ebuild,v 1.3 2012/10/26 12:15:36 ago Exp $

EAPI=4

inherit autotools toolchain-funcs

DESCRIPTION="Filesystem for rdiff-backup'ed folders"
HOMEPAGE="http://code.google.com/p/rdiff-backup-fs/"
SRC_URI="http://archfs.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-fs/fuse"
RDEPEND="${DEPEND}
	app-backup/rdiff-backup"

S="${WORKDIR}/${P/b}"

DOCS=( AUTHORS ChangeLog NEWS )

src_prepare() {
	sed -i configure.ac \
		-e 's|-Wall -O3|-Wall|g' \
		-e 's| -lfuse||g' \
		-e 's|CFLAGS|INCLUDES|g' \
		-e 's|LDFLAGS|LIBS|g' \
		|| die "sed failed"
	eautoreconf
}

src_compile() {
	emake AR="$(tc-getAR)"
}
