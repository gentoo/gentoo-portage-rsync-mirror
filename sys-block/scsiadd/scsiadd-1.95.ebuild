# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/scsiadd/scsiadd-1.95.ebuild,v 1.2 2012/05/24 05:11:54 vapier Exp $

inherit user toolchain-funcs flag-o-matic

DESCRIPTION="Add and remove SCSI devices from your Linux system during runtime"
HOMEPAGE="http://llg.cubic.org/tools/"
SRC_URI="http://llg.cubic.org/tools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="suid"
DEPEND=""

pkg_setup() {
	use suid && enewgroup scsi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# remove 'strip' command
	sed -i -e "s:^\(.*strip.*\):#\1:g" Makefile.in
}

src_compile() {
	# extra safety for suid
	append-ldflags -Wl,-z,now

	econf || die "econf failed"
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dosbin scsiadd || die "install failed"
	if use suid; then
		fowners root:scsi /usr/sbin/scsiadd
		fperms  4710      /usr/sbin/scsiadd
	fi
	dodoc NEWS README TODO
	doman scsiadd.8
}

pkg_postinst() {
	if use suid; then
		ewarn
		ewarn "You have chosen to install ${PN} with the binary setuid root. This"
		ewarn "means that if there any undetected vulnerabilities in the binary,"
		ewarn "then local users may be able to gain root access on your machine."
		ewarn
	fi
}
