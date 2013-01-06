# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mkinitcpio-nfs-utils/mkinitcpio-nfs-utils-0.3.ebuild,v 1.2 2012/07/04 18:19:10 xmw Exp $

EAPI=4

inherit eutils

DESCRIPTION="ipconfig and nfsmount tools for NFS root support in mkinitcpio ported from Arch Linux"
HOMEPAGE="http://www.archlinux.org/"
SRC_URI="ftp://ftp.archlinux.org/other/mkinitcpio/${P}.tar.xz -> ${P}.tar.gz" # intentional, arch plz.

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-kernel/mkinitcpio"
DEPEND=""

src_prepare() {
	tc-export CC
	epatch "${FILESDIR}"/${P}-buildsystem.patch
}
