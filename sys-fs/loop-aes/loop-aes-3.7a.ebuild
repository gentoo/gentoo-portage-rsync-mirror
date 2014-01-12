# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/loop-aes/loop-aes-3.7a.ebuild,v 1.3 2014/01/12 19:52:18 pacho Exp $

EAPI="3"

inherit linux-mod

MY_P="${PN/aes/AES}-v${PV}"

DESCRIPTION="Linux kernel module to encrypt local file systems and disk partitions with AES cipher."
HOMEPAGE="http://loop-aes.sourceforge.net/loop-AES.README"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ~hppa ~ppc ~sparc ~x86"
IUSE="aes-ni extra-ciphers keyscrub padlock"

DEPEND="|| ( >=sys-apps/util-linux-2.12r[crypt,loop-aes] app-crypt/loop-aes-losetup )"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	linux-mod_pkg_setup

	CONFIG_CHECK="!BLK_DEV_LOOP"
	MODULE_NAMES="loop(block::tmp-d-kbuild)"
	BUILD_TARGETS="all"

	BUILD_PARAMS=" \
		V=1 \
		LINUX_SOURCE=\"${KERNEL_DIR}\" \
		KBUILD_OUTPUT=\"${KBUILD_OUTPUT}\" \
		USE_KBUILD=y MODINST=n RUNDM=n"
	use aes-ni && BUILD_PARAMS="${BUILD_PARAMS} INTELAES=y"
	use keyscrub && BUILD_PARAMS="${BUILD_PARAMS} KEYSCRUB=y"
	use padlock && BUILD_PARAMS="${BUILD_PARAMS} PADLOCK=y"

	if use extra-ciphers; then
		MODULE_NAMES="${MODULE_NAMES}
			loop_blowfish(block::tmp-d-kbuild)
			loop_serpent(block::tmp-d-kbuild)
			loop_twofish(block::tmp-d-kbuild)"
		BUILD_PARAMS="${BUILD_PARAMS} EXTRA_CIPHERS=y"
	fi
}

src_prepare() {
	sed -e 's/make/$(MAKE)/g' -i Makefile || die "sed failed"
}

src_install() {
	linux-mod_src_install

	dodoc README || die "dodoc failed"
	dobin loop-aes-keygen || die "dobin failed"
	doman loop-aes-keygen.1 || die "doman failed"
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo
	einfo "For more instructions take a look at examples in README at:"
	einfo "'${EPREFIX}/usr/share/doc/${PF}'"
	einfo
	einfo "If you have a newer Intel processor (i5, i7), and you use AES"
	einfo "you may want to consider using the aes-ni use flag. It will"
	einfo "use your processors native AES instructions giving quite a speed"
	einfo "increase."
	einfo

	ewarn
	ewarn "Please consider using loop-aes-losetup package instead of"
	ewarn "util-linux[loop-aes], it will enable all loop-aes services"
	ewarn "without patching util-linux package"
	ewarn
	ewarn "In future only loop-aes-losetup will be available in portage"
	ewarn
}
