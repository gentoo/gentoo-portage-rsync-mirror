# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/yaboot/yaboot-1.3.17.ebuild,v 1.1 2012/02/24 15:15:33 josejx Exp $

inherit eutils toolchain-funcs

DESCRIPTION="PPC Bootloader"
SRC_URI="http://yaboot.ozlabs.org/releases/${P}.tar.gz"
HOMEPAGE="http://yaboot.ozlabs.org"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* ~ppc -ppc64"
IUSE="ibm"

DEPEND="sys-apps/powerpc-utils"
RDEPEND="!ibm? ( sys-fs/hfsutils
				 sys-fs/hfsplusutils
				 sys-fs/mac-fdisk )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp "${FILESDIR}/new-ofpath" "${S}/ybin/ofpath"

	# dual boot patch
	epatch "${FILESDIR}/yabootconfig-1.3.13.patch"
	epatch "${FILESDIR}/chrpfix.patch"
	if [[ "$(gcc-major-version)" -eq "3" ]]; then
		epatch "${FILESDIR}/${PN}-nopiessp.patch"
	fi
	if [[ "$(gcc-major-version)" -eq "4" ]]; then
		epatch "${FILESDIR}/${P}-nopiessp-gcc4.patch"
	fi

	# Error only on real errors, for prom printing format compile failure
	sed -i "s:-Werror:-Wno-error:g" Makefile
}

src_compile() {
	export -n CFLAGS
	export -n CXXFLAGS
	[ -n "$(tc-getCC)" ] || CC="gcc"
	emake PREFIX=/usr MANDIR=share/man CC="$(tc-getCC)" || die
}

src_install() {
	sed -i -e 's/\/local//' etc/yaboot.conf
	make ROOT="${D}" PREFIX=/usr MANDIR=share/man install || die
	mv "${D}/etc/yaboot.conf" "${D}/etc/yaboot.conf.sample"
}
