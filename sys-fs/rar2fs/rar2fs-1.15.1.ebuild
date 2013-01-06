# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/rar2fs/rar2fs-1.15.1.ebuild,v 1.1 2012/05/07 11:10:47 ssuominen Exp $

EAPI=4
inherit autotools

DESCRIPTION="A FUSE based filesystem that can mount one or multiple RAR archive(s)"
HOMEPAGE="http://code.google.com/p/rar2fs/"
SRC_URI="http://rar2fs.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=app-arch/unrar-4.2
	sys-fs/fuse"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog"

src_prepare() {
	sed -i -e '/FLAGS.*O0/d' configure.ac || die
	eautoreconf
}

src_configure() {
	local mydebug
	use debug && mydebug="--enable-debug=4"

	econf \
		--with-unrar=/usr/include/libunrar \
		${mydebug}
}
