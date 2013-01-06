# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libsafe/libsafe-2.0_p16-r2.ebuild,v 1.2 2008/12/31 03:43:36 mr_bones_ Exp $

inherit flag-o-matic toolchain-funcs multilib

MY_P="${P/_p/-}"
DESCRIPTION="Protection against buffer overflow vulnerabilities"
HOMEPAGE="http://www.research.avayalabs.com/gcm/usa/en-us/initiatives/all/nsr.htm&Filter=ProjectTitle:Libsafe&Wrapper=LabsProjectDetails&View=LabsProjectDetails"
SRC_URI="http://www.research.avayalabs.com/project/libsafe/src/${MY_P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	filter-flags -fomit-frame-pointer

	sed -i \
		-e "s:gcc:$(tc-getCC):" \
		-e "/^CCFLAGS/s:-O2:${CFLAGS}:" \
		-e "/^LDFLAGS/s:= := ${LDFALGS}:" \
		-e "s:\$(LIBPRELUDE_CFLAGS)::" \
		-e "s:\$(LIBPRELUDE_LIBS)::" \
		src/Makefile || die
}

src_compile() {
	emake libsafe || die
}

src_install() {
	# libsafe stuff
	into /
	dolib.so src/libsafe.so.${PV/_p/.} || die
	# dodir /lib
	dosym libsafe.so.${PV/_p/.} /$(get_libdir)/libsafe.so || die
	dosym libsafe.so.${PV/_p/.} /$(get_libdir)/libsafe.so.${PV%%.*} || die

	# Documentation
	doman doc/libsafe.8
	dohtml doc/libsafe.8.html

	dodoc README
	# use prelude && dodoc LIBPRELUDE
	# use mta && dodoc EMAIL_NOTIFICATION
}

pkg_postinst() {
	einfo
	einfo "To use this you have to put the library as one of the variables"
	einfo "in LD_PRELOAD."
	einfo "Example in bash:"
	einfo "export LD_PRELOAD=libsafe.so.${PV%%.*}"
	einfo
}
