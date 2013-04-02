# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/f2fs-tools/f2fs-tools-1.1.0.ebuild,v 1.2 2013/04/02 11:25:14 blueness Exp $

EAPI=4

DESCRIPTION="Tools for Flash-Friendly File System (F2FS) "
HOMEPAGE="http://git.kernel.org/?p=linux/kernel/git/jaegeuk/f2fs-tools.git;a=summary"
SRC_URI="http://dev.gentoo.org/~blueness/f2fs-tools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_configure () {
	econf --prefix=/
}
