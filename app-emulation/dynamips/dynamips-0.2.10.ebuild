# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/dynamips/dynamips-0.2.10.ebuild,v 1.1 2013/10/20 07:24:02 pinkbyte Exp $

EAPI=5

MY_P="${P}-source"

inherit eutils toolchain-funcs

DESCRIPTION="Cisco 7200/3600 Simulator"
HOMEPAGE="http://www.gns3.net/dynamips/"
SRC_URI="mirror://sourceforge/project/gns-3/Dynamips/${PV}/${MY_P}.zip"

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
	sed -i \
		-e 's/@$(CC)/$(CC)/g' \
		stable/Makefile || die 'sed on stable/Makefile failed'
	# respect compiler
	tc-export CC

	epatch_user
}

src_compile() {
	if use amd64 || use x86; then
		emake DYNAMIPS_ARCH="${ARCH}"
	else
		emake DYNAMIS_ARCH="nojit"
	fi
}

src_install () {
	newbin dynamips.stable dynamips
	dobin stable/nvram_export
	doman man/*
	dodoc README README.hypervisor TODO
}
