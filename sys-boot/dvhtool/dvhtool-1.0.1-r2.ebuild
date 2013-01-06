# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/dvhtool/dvhtool-1.0.1-r2.ebuild,v 1.4 2011/08/18 03:35:05 mattst88 Exp $

EAPI=4

inherit autotools eutils toolchain-funcs

DESCRIPTION="Tool to copy kernel(s) into the volume header on SGI MIPS-based workstations."
HOMEPAGE="http://packages.debian.org/unstable/utils/dvhtool"
SRC_URI="mirror://debian/pool/main/d/dvhtool/dvhtool_1.0.1.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~x86"
IUSE=""
DEPEND=""
RDEPEND=""

S="${S}.orig"

src_prepare() {
	# several applicable hunks from a debian patch
	epatch "${FILESDIR}"/${P}-debian.diff

	# Newer minor patches from Debian
	epatch "${FILESDIR}"/${P}-debian-warn_type_guess.diff
	epatch "${FILESDIR}"/${P}-debian-xopen_source.diff

	# Allow dvhtool to recognize Linux RAID and Linux LVM partitions
	epatch "${FILESDIR}"/${P}-add-raid-lvm-parttypes.patch

	eautoreconf
}

src_configure() {
	CC=$(tc-getCC) LD=$(tc-getLD) \
		econf
}

src_compile() {
	CC=$(tc-getCC) LD=$(tc-getLD) \
		emake
}
