# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/dynamips/dynamips-0.2.8_rc2-r1.ebuild,v 1.1 2010/10/17 12:58:02 chainsaw Exp $

inherit eutils

MY_P="${P/_rc/-RC}"

DESCRIPTION="Cisco 7200/3600 Simulator"
HOMEPAGE="http://www.ipflow.utc.fr/index.php/Cisco_7200_Simulator"
SRC_URI="http://www.ipflow.utc.fr/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="dev-libs/elfutils
	net-libs/libpcap"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-makefile.patch"

	if use amd64; then
		sed -i \
			-e 's:DYNAMIPS_ARCH?=nojit:DYNAMIPS_ARCH?=amd64:g' \
			Makefile || die "Failed to optimise for AMD64"
	elif use amd64; then
		sed -i \
			-e 's:DYNAMIPS_ARCH?=nojit:DYNAMIPS_ARCH?=x86:g' \
			Makefile || die "Failed to optimise for X86"
	fi
}

src_install () {
	dobin dynamips nvram_export \
		|| die "Installing binaries failed"
	doman dynamips.1 hypervisor_mode.7 nvram_export.1 \
		|| die "Installing man pages failed"
	dodoc ChangeLog TODO README README.hypervisor \
		|| die "Installing docs failed"
}
