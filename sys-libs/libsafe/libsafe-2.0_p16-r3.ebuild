# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libsafe/libsafe-2.0_p16-r3.ebuild,v 1.1 2013/03/15 13:14:59 pinkbyte Exp $

EAPI=5

inherit eutils flag-o-matic multilib readme.gentoo toolchain-funcs

MY_P="${P/_p/-}"
DESCRIPTION="Protection against buffer overflow vulnerabilities"
HOMEPAGE="http://www.research.avayalabs.com/gcm/usa/en-us/initiatives/all/nsr.htm&Filter=ProjectTitle:Libsafe&Wrapper=LabsProjectDetails&View=LabsProjectDetails"
SRC_URI="http://www.research.avayalabs.com/project/libsafe/src/${MY_P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

DISABLE_AUTOFORMATTING=1
DOC_CONTENTS="To use this you have to put the library
as one of the variables in LD_PRELOAD.
Example in bash:
export LD_PRELOAD=libsafe.so.${PV%%.*}"

src_prepare() {
	filter-flags -fomit-frame-pointer

	sed -i \
		-e 's:gcc:$(CC):' \
		-e "/^CCFLAGS/s:= -O2:= ${CFLAGS}:" \
		-e "/^LDFLAGS/s:=:+=:" \
		-e "s:\$(LIBPRELUDE_CFLAGS)::" \
		-e "s:\$(LIBPRELUDE_LIBS)::" \
		src/Makefile || die

	epatch_user
}

src_compile() {
	emake CC="$(tc-getCC)" libsafe
}

src_install() {
	# libsafe stuff
	into /
	dolib.so src/libsafe.so.${PV/_p/.}
	dosym libsafe.so.${PV/_p/.} /$(get_libdir)/libsafe.so
	dosym libsafe.so.${PV/_p/.} /$(get_libdir)/libsafe.so.${PV%%.*}

	# Documentation
	doman doc/libsafe.8
	dohtml doc/libsafe.8.html

	dodoc README
	readme.gentoo_create_doc
	# use prelude && dodoc LIBPRELUDE
	# use mta && dodoc EMAIL_NOTIFICATION
}
