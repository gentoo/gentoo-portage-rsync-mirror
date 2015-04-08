# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/rdiff-backup-fs/rdiff-backup-fs-1.0.0.ebuild,v 1.1 2013/06/17 09:18:28 pinkbyte Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1
inherit autotools-utils

DESCRIPTION="Filesystem for rdiff-backup'ed folders, successor of archfs"
HOMEPAGE="http://code.google.com/p/rdiff-backup-fs/"
SRC_URI="http://rdiff-backup-fs.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="sys-fs/fuse"
RDEPEND="${DEPEND}
	app-backup/rdiff-backup"

DOCS=( AUTHORS ChangeLog NEWS )

src_prepare() {
	sed -i configure.ac \
		-e 's|-Wall -O3|-Wall|g' \
		-e 's| -lfuse||g' \
		-e 's|CFLAGS|AM_CPPFLAGS|g' \
		-e 's|LDFLAGS|LIBS|g' \
		-e '/AC_PROG_RANLIB/a\ AM_PROG_AR' \
		|| die "sed failed"

	autotools-utils_src_prepare
}
