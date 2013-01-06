# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/dynamips/dynamips-0.2.8_rc3.ebuild,v 1.2 2012/05/05 02:58:28 pva Exp $

EAPI=3
inherit base

MY_P="${P/_rc/-RC}-community"
MY_PV="${PV/_rc/-RC}-community"

DESCRIPTION="Cisco 7200/3600 Simulator"
HOMEPAGE="http://www.gns3.net/dynamips/"
SRC_URI="mirror://sourceforge/project/gns-3/Dynamips/${MY_PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="dev-libs/elfutils
	net-libs/libpcap"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
PATCHES=(
	"${FILESDIR}/${P}-makefile.patch"
)

src_prepare() {
	base_src_prepare
	if use amd64; then
		ebegin "Adjusting Makefiles for AMD64"
		sed -i \
			-e 's:DYNAMIPS_ARCH?=nojit:DYNAMIPS_ARCH?=amd64:g' \
			Makefile || die "Failed to optimise for AMD64; stage 1"
		sed -i \
			-e 's:DYNAMIPS_ARCH?=nojit:DYNAMIPS_ARCH?=amd64:g' \
			stable/Makefile || die "Failed to optimise for AMD64; stage 2"
		eend $?
	elif use x86; then
		ebegin "Adjusting Makefiles for X86"
		sed -i \
			-e 's:DYNAMIPS_ARCH?=nojit:DYNAMIPS_ARCH?=x86:g' \
			Makefile || die "Failed to optimise for X86; stage 1"
		sed -i \
			-e 's:DYNAMIPS_ARCH?=nojit:DYNAMIPS_ARCH?=x86:g' \
			stable/Makefile || die "Failed to optimise for X86; stage 2"
		eend $?
	fi
}

src_install () {
	newbin dynamips.stable dynamips \
		|| die "Installing main binary failed"
	dobin stable/nvram_export \
		|| die "Installing support binaries failed"
	doman dynamips.1 hypervisor_mode.7 nvram_export.1 \
		|| die "Installing man pages failed"
	dodoc TODO README README.community README.hypervisor \
		|| die "Installing docs failed"
}
