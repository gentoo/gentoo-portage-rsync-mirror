# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/tpm-emulator/tpm-emulator-0.5.1-r1.ebuild,v 1.3 2012/12/11 15:44:01 axs Exp $

EAPI=2
inherit toolchain-funcs linux-mod eutils multilib udev user

MY_P=${P/-/_}
DESCRIPTION="Emulator driver for tpm"
HOMEPAGE="https://developer.berlios.de/projects/tpm-emulator"

SRC_URI="mirror://berlios/tpm-emulator/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="modules"
DEPEND="dev-libs/gmp
	virtual/pkgconfig"
RDEPEND=""
S=${WORKDIR}/${P/-/_}

#fixups at:
#https://developer.berlios.de/feature/index.php?func=detailfeature&feature_id=3304&group_id=2491

pkg_setup() {
	use modules && linux-mod_pkg_setup
	MODULE_NAMES="tpmd_dev(crypt::${S}/tpmd_dev)"
	BUILD_TARGETS="all"
	BUILD_PARAMS="CC=$(tc-getCC)"
	enewuser tss -1 -1 /var/lib/tpm tss
}

src_prepare() {
	sed -i 's/LDFLAGS :=/override LDFLAGS +=/g' tpmd/Makefile
	sed -i 's#/var/tpm#/var/run/tpm#g' tpmd/tpmd.c tddl/tddl.c tpmd_dev/tpmd_dev.c

	# use kernel object directory found by linux-info getversion() (bug 241956)
	sed -i 's#/lib/modules/\$(KERNEL_RELEASE)/build#'"${KV_OUT_DIR}#" tpmd_dev/Makefile

	# reorder -lgmp so --as-needed works (bug 264073)
	sed -i 's/LDFLAGS/LDLIBS/' tpmd/Makefile

	# fix parallel make
	epatch "${FILESDIR}"/${P}-parallel-make.patch
}

src_compile() {
	emake user || die "Failed to build userspace"
	if use modules; then
		linux-mod_src_compile || die "Failed to build kernelspace"
	fi
}

src_install() {
	if [ -x /usr/bin/scanelf -a -f tpm_emulator.ko ]; then
		[ -z "$(/usr/bin/scanelf -qs __guard tpm_emulator.ko)" ] || \
			die 'cannot have gmp compiled with hardened flags'
		[ -z "$(/usr/bin/scanelf -qs __stack_smash_handler tpm_emulator.ko)" ] || \
			die 'cannot have gmp compiled with hardened flags'
	fi

	use modules && linux-mod_src_install
	dodoc README

	emake user_install DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" \
		|| die "Failed to install userspace"

	newinitd "${FILESDIR}"/${PN}.initd-0.5.1 ${PN}
	newconfd "${FILESDIR}"/${PN}.confd-0.5.1 ${PN}

	udev_newrules "${FILESDIR}"/${PN}.udev 60-${PN}.rules

	keepdir /var/run/tpm
	fowners tss /var/run/tpm

	keepdir /var/log/tpm
	fowners tss:tss /var/log/tpm
}
