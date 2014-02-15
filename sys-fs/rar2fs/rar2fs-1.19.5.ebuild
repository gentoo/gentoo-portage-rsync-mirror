# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/rar2fs/rar2fs-1.19.5.ebuild,v 1.2 2014/02/15 10:27:33 radhermit Exp $

EAPI=5

# upstream uses google drive that has hash-based URLs
GD_HASH="0B-2uEqYiZg3zd2k4Q3duUUUtczA"

DESCRIPTION="A FUSE based filesystem that can mount one or multiple RAR archive(s)"
HOMEPAGE="http://code.google.com/p/rar2fs/"
SRC_URI="https://docs.google.com/uc?export=download&id=${GD_HASH} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=app-arch/unrar-5:=
	sys-fs/fuse"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog"

src_configure() {
	export USER_CFLAGS="${CFLAGS}"

	econf \
		--with-unrar=/usr/include/libunrar \
		$(use_enable debug)
}
