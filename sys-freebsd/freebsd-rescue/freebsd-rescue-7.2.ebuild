# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-rescue/freebsd-rescue-7.2.ebuild,v 1.2 2010/03/11 11:09:04 aballier Exp $

EAPI=2

inherit bsdmk freebsd

DESCRIPTION="FreeBSD's rescue binaries"
SLOT="0"
KEYWORDS="~x86-fbsd"

IUSE="atm nis"

SRC_URI="mirror://gentoo/${UBIN}.tar.bz2
		mirror://gentoo/${CONTRIB}.tar.bz2
		mirror://gentoo/${LIB}.tar.bz2
		mirror://gentoo/${BIN}.tar.bz2
		mirror://gentoo/${SBIN}.tar.bz2
		mirror://gentoo/${USBIN}.tar.bz2
		mirror://gentoo/${GNU}.tar.bz2
		mirror://gentoo/${SYS}.tar.bz2
		mirror://gentoo/${LIBEXEC}.tar.bz2
		mirror://gentoo/${RESCUE}.tar.bz2"

RDEPEND=""
DEPEND="sys-devel/flex
	=sys-freebsd/freebsd-lib-${RV}*[atm?]
	=sys-freebsd/freebsd-sources-${RV}*
	=sys-freebsd/freebsd-mk-defs-${RV}*"

S="${WORKDIR}/rescue"

pkg_setup() {
	use atm || mymakeopts="${mymakeopts} NO_ATM= "
	use nis || mymakeopts="${mymakeopts} NO_NIS= "

#	append-flags -fno-stack-protector -fno-stack-protector-all
}

src_prepare() {
	# As they are patches from ${WORKDIR} apply them by hand
	cd "${WORKDIR}"
	epatch "${FILESDIR}/${PN}"-5.4-gentoo.patch
	epatch "${FILESDIR}/${PN}"-7.1-zlib.patch
}
