# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/kexec-tools/kexec-tools-9999.ebuild,v 1.9 2013/11/11 15:57:11 jlec Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils flag-o-matic git-2 linux-info systemd

DESCRIPTION="Load another kernel from the currently executing Linux kernel"
HOMEPAGE="http://kernel.org/pub/linux/utils/kernel/kexec/"
SRC_URI=""
EGIT_REPO_URI="git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="booke lzma xen"

DEPEND="lzma? ( app-arch/xz-utils )"
RDEPEND="${DEPEND}"

CONFIG_CHECK="~KEXEC"

PATCHES=( "${FILESDIR}"/${PN}-2.0.4-disable-kexec-test.patch )

pkg_setup() {
	# GNU Make's $(COMPILE.S) passes ASFLAGS to $(CCAS), CCAS=$(CC)
	export ASFLAGS="${CCASFLAGS}"
	# to disable the -fPIE -pie in the hardened compiler
	if gcc-specs-pie ; then
		filter-flags -fPIE
		append-ldflags -nopie
	fi
}

src_configure() {
	local myeconfargs=(
		$(use_with booke)
		$(use_with lzma)
		$(use_with xen)
		)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	dodoc "${FILESDIR}"/README.Gentoo

	newinitd "${FILESDIR}"/kexec.init-${PV} kexec
	newconfd "${FILESDIR}"/kexec.conf-${PV} kexec

	insinto /etc
	doins "${FILESDIR}"/kexec.conf

	systemd_dounit "${FILESDIR}"/kexec.service
}

pkg_postinst() {
	if systemd_is_booted || has_version sys-apps/systemd; then
		elog "For systemd support the new config file is"
		elog "   /etc/kexec.conf"
		elog "Please adopt it to your needs as there is no autoconfig anymore"
	fi
}
