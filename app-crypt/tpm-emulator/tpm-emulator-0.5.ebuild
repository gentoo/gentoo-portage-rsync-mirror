# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/tpm-emulator/tpm-emulator-0.5.ebuild,v 1.5 2012/05/31 03:31:59 zmedico Exp $

inherit toolchain-funcs linux-mod eutils user

MY_P=${P/-/_}
DESCRIPTION="Emulator driver for tpm"
HOMEPAGE="https://developer.berlios.de/projects/tpm-emulator"

SRC_URI="mirror://berlios/tpm-emulator/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="dev-libs/gmp"
RDEPEND=""
S=${WORKDIR}/${P/-/_}

#fixups at:
#https://developer.berlios.de/feature/index.php?func=detailfeature&feature_id=3304&group_id=2491

pkg_setup() {
	linux-mod_pkg_setup
	MODULE_NAMES="tpmd_dev(crypt::${S}/tpmd_dev)"
	BUILD_TARGETS="all"
	BUILD_PARAMS="CC=$(tc-getCC)"
	enewuser tss
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's/LDFLAGS :=/override LDFLAGS +=/g' tpmd/Makefile
	sed -i 's#/var/tpm#/var/run/tpm#g' tpmd/tpmd.c tddl/tddl.c tpm_dev/linux_module.c
}

src_install() {
	if [ -x /usr/bin/scanelf ]; then
		[ -z "$(/usr/bin/scanelf -qs __guard tpm_emulator.ko)" ] || \
			die 'cannot have gmp compiled with hardened flags'
		[ -z "$(/usr/bin/scanelf -qs __stack_smash_handler tpm_emulator.ko)" ] || \
			die 'cannot have gmp compiled with hardened flags'
	fi

	linux-mod_src_install
	dodoc README
	dosbin tpmd/tpmd
	dolib.so tddl/libtddl.so
	insinto /usr/include
	doins tddl/tddl.h
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	insinto /etc/udev/rules.d
	newins "${FILESDIR}/${PN}.udev" "60-${PN}.rules"
	keepdir /var/run/tpm
	fowners tss /var/run/tpm
}
