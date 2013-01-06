# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/microcode-ctl/microcode-ctl-1.17-r2.ebuild,v 1.3 2011/01/24 14:16:01 darkside Exp $

inherit linux-info toolchain-funcs

MY_P=${PN/-/_}-${PV}
DESCRIPTION="Intel processor microcode update utility"
HOMEPAGE="http://www.urbanmyth.org/microcode"
SRC_URI="http://www.urbanmyth.org/microcode/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""

RDEPEND=">=sys-apps/microcode-data-20090330"

S=${WORKDIR}/${MY_P}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} ${CPPFLAGS} ${LDFLAGS}" \
		|| die "compile problem"
}

src_install() {
	dosbin microcode_ctl || die "dosbin"
	doman microcode_ctl.8
	dodoc Changelog README

	newinitd "${FILESDIR}"/microcode_ctl.rc-r1 microcode_ctl
	newconfd "${FILESDIR}"/microcode_ctl.conf.d microcode_ctl
}

pkg_postinst() {
	# Just a friendly warning
	if ! linux_config_exists || ! linux_chkconfig_present MICROCODE; then
		echo
		ewarn "Your kernel must include microcode update support."
		ewarn "  Processor type and features --->"
		ewarn "  <*> /dev/cpu/microcode - microcode support"
		echo
	fi
	elog "Microcode updates will be lost at every reboot."
	elog "You can use the init.d script to update at boot time."
}
