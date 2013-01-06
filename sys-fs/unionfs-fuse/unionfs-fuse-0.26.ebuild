# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/unionfs-fuse/unionfs-fuse-0.26.ebuild,v 1.3 2012/09/23 23:54:04 mr_bones_ Exp $

EAPI="3"

inherit eutils

DESCRIPTION="Self-syncing tree-merging file system based on FUSE"

HOMEPAGE="http://podgorny.cz/moin/UnionFsFuse"
SRC_URI="http://podgorny.cz/unionfs-fuse/releases/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-fs/fuse"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-link-pthread.patch
	epatch "${FILESDIR}"/${P}-declare-chroot.patch
}

src_install() {
	dodir /usr/sbin /usr/share/man/man8/ || die "dodir failed"
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed"
}
