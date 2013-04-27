# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/reiserfsprogs/reiserfsprogs-3.6.22.ebuild,v 1.2 2013/04/27 09:38:04 vapier Exp $

EAPI="4"

inherit eutils flag-o-matic

DESCRIPTION="Reiserfs Utilities"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/fs/reiserfs/"
SRC_URI="mirror://kernel/linux/utils/fs/reiserfs/${P}.tar.xz
	mirror://kernel/linux/kernel/people/jeffm/${PN}/v${PV}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 -sparc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.6.21-fsck-n.patch
	sed -i '/VERSION=/s:21:22:' configure || die
}

src_configure() {
	append-flags -std=gnu89 #427300
	econf --prefix="${EPREFIX}/"
}
