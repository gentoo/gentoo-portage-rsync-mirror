# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unace/unace-2.5-r2.ebuild,v 1.10 2013/02/20 09:54:31 ago Exp $

inherit eutils toolchain-funcs

DEB_VER="5"
DESCRIPTION="ACE unarchiver"
HOMEPAGE="http://www.winace.com/"
SRC_URI="mirror://debian/pool/non-free/u/unace-nonfree/unace-nonfree_${PV}.orig.tar.gz
	mirror://debian/pool/non-free/u/unace-nonfree/unace-nonfree_${PV}-${DEB_VER}.diff.gz"

LICENSE="freedist"
SLOT="1"
KEYWORDS="alpha amd64 ~arm hppa ppc ppc64 s390 x86 ~amd64-linux ~x86-linux ~sparc-solaris"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/unace-nonfree_${PV}-${DEB_VER}.diff
	local p
	for p in $(<unace-nonfree-${PV}/debian/patches/00list) ; do
		epatch unace-nonfree-${PV}/debian/patches/${p}.dpatch
	done
	epatch "${FILESDIR}"/${P}-endianness-detection.patch
	tc-export CC
}

src_install() {
	dobin unace || die
	doman unace-nonfree-${PV}/debian/manpage/unace.1
}
