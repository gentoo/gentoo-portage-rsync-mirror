# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/device-mapper/device-mapper-1.02.19.ebuild,v 1.12 2011/02/06 10:51:16 leio Exp $

inherit eutils multilib toolchain-funcs

DESCRIPTION="Device mapper ioctl library for use with LVM2 utilities"
HOMEPAGE="http://sources.redhat.com/dm/"
SRC_URI="ftp://sources.redhat.com/pub/dm/${PN}.${PV}.tgz
	ftp://sources.redhat.com/pub/dm/old/${PN}.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE="selinux"

DEPEND="selinux? ( sys-libs/libselinux )"

S=${WORKDIR}/${PN}.${PV}

src_compile() {
	econf --sbindir=/sbin $(use_enable selinux) || die "econf failed"
	emake || die "compile problem"
}

src_install() {
	make install DESTDIR="${D}" || die

	# move shared libs to /
	mv "${D}"/usr/$(get_libdir) "${D}"/ || die "move libdir"
	dolib.a lib/ioctl/libdevmapper.a || die "dolib.a"
	gen_usr_ldscript libdevmapper.so

	insinto /etc
	doins "${FILESDIR}"/dmtab
	insinto /lib/rcscripts/addons
	doins "${FILESDIR}"/dm-start.sh

	newinitd "${FILESDIR}"/device-mapper.rc device-mapper || die

	dodoc INSTALL INTRO README VERSION WHATS_NEW
}

pkg_preinst() {
	local l=${ROOT}/$(get_libdir)/libdevmapper.so.1.01
	[[ -e ${l} ]] && cp "${l}" "${D}"/$(get_libdir)/
}

pkg_postinst() {
	preserve_old_lib_notify /$(get_libdir)/libdevmapper.so.1.01

	elog "device-mapper volumes are no longer automatically created for"
	elog "baselayout-2 users. If you are using baselayout-2, be sure to"
	elog "run: # rc-update add device-mapper boot"
}
