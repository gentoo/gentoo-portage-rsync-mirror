# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/msp430-gdb/msp430-gdb-7.2_p20111205.ebuild,v 1.4 2012/04/24 09:52:10 mgorny Exp $

EAPI="4"

inherit flag-o-matic eutils

export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi
is_cross() { [[ ${CHOST} != ${CTARGET} ]] ; }

MY_PV="${PV%_p*}"
DESCRIPTION="GNU debugger for MSP430 microcontrollers"
HOMEPAGE="http://sources.redhat.com/gdb/"
SRC_URI="mirror://gnu/gdb/gdb-${MY_PV}.tar.bz2
	ftp://sources.redhat.com/pub/gdb/releases/gdb-${MY_PV}.tar.bz2
	http://dev.gentoo.org/~radhermit/distfiles/${P}.patch.bz2"

LICENSE="GPL-2 LGPL-2"
is_cross \
	&& SLOT="${CTARGET}" \
	|| SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="expat multitarget nls python test"

RDEPEND=">=sys-libs/ncurses-5.2-r2
	sys-libs/readline
	expat? ( dev-libs/expat )
	python? ( =dev-lang/python-2* )"
DEPEND="${RDEPEND}
	virtual/yacc
	test? ( dev-util/dejagnu )
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/gdb-${MY_PV}"

pkg_pretend() {
	is_cross || die "Only cross-compile builds are supported"
}

src_prepare() {
	strip-linguas -u bfd/po opcodes/po

	epatch "${WORKDIR}"/${P}.patch
}

src_configure() {
	strip-unsupported-flags
	econf \
		--with-pkgversion="Gentoo MSP430 ${PV}" \
		--with-bugurl='http://bugs.gentoo.org/' \
		--disable-werror \
		--enable-64-bit-bfd \
		--with-system-readline \
		$(is_cross && echo --with-sysroot="${EPREFIX}"/usr/${CTARGET}) \
		$(use_with expat) \
		$(use_enable nls) \
		$(use multitarget && echo --enable-targets=all) \
		$(use_with python python "${EPREFIX}/usr/bin/python2")
}

src_test() {
	emake check || ewarn "tests failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		libdir=/nukeme/pretty/pretty/please includedir=/nukeme/pretty/pretty/please \
		install || die
	rm -r "${D}"/nukeme || die

	# Don't install docs when building a cross-gdb
	if [[ ${CTARGET} != ${CHOST} ]] ; then
		rm -r "${ED}"/usr/share
		return 0
	fi

	dodoc README
	docinto gdb
	dodoc gdb/CONTRIBUTE gdb/README gdb/MAINTAINERS \
		gdb/NEWS gdb/ChangeLog gdb/PROBLEMS
	docinto sim
	dodoc sim/ChangeLog sim/MAINTAINERS sim/README-HACKING

	dodoc "${WORKDIR}"/extra/gdbinit.sample

	# Remove shared info pages
	rm -f "${ED}"/usr/share/info/{annotate,bfd,configure,standards}.info*
}

pkg_postinst() {
	# portage sucks and doesnt unmerge files in /etc
	rm -vf "${ROOT}"/etc/skel/.gdbinit

	if use prefix && [[ ${CHOST} == *-darwin* ]] ; then
		ewarn "gdb is unable to get a mach task port when installed by Prefix"
		ewarn "Portage, unprivileged.  To make gdb fully functional you'll"
		ewarn "have to perform the following steps:"
		ewarn "  % sudo chgrp procmod ${EPREFIX}/usr/bin/gdb"
		ewarn "  % sudo chmod g+s ${EPREFIX}/usr/bin/gdb"
	fi
}
