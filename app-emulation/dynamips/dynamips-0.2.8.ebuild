# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/dynamips/dynamips-0.2.8.ebuild,v 1.1 2013/07/15 15:48:51 pinkbyte Exp $

EAPI=5

inherit eutils toolchain-funcs

MY_PV="${PV/_rc/-RC}-community"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Cisco 7200/3600 Simulator"
HOMEPAGE="http://www.gns3.net/dynamips/"
SRC_URI="mirror://sourceforge/project/gns-3/Dynamips/${MY_PV}/${MY_P}.source.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip
	dev-libs/elfutils
	net-libs/libpcap"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile.patch"

	# enable verbose build
	sed -i -e 's/@$(CC)/$(CC)/g' stable/Makefile || die 'sed on Makefile failed'
	# respect compiler
	tc-export CC

	epatch_user
}

src_compile() {
	if use amd64 || use x86; then
		emake DYNAMIPS_ARCH="${ARCH}"
	else
		emake
	fi
}

src_install () {
	newbin dynamips.stable dynamips
	dobin stable/nvram_export
	doman man/*
	dodoc TODO README README.hypervisor
}
