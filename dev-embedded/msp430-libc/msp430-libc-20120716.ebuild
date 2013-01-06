# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/msp430-libc/msp430-libc-20120716.ebuild,v 1.1 2012/08/30 18:21:30 radhermit Exp $

EAPI="4"

CHOST="msp430"
CTARGET="msp430"

DESCRIPTION="C library for MSP430 microcontrollers"
HOMEPAGE="http://mspgcc.sourceforge.net"
SRC_URI="mirror://sourceforge/mspgcc/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="crosscompile_opts_headers-only"

DEPEND="sys-devel/crossdev"
[[ ${CATEGORY/cross-} != ${CATEGORY} ]] \
	&& RDEPEND="!dev-embedded/msp430-libc" \
	|| RDEPEND=""

S=${WORKDIR}/${P}/src

pkg_setup() {
	ebegin "Checking for msp430-gcc"
	if type -p msp430-gcc > /dev/null ; then
		eend 0
	else
		eend 1

		eerror
		eerror "Failed to locate 'msp430-gcc' in \$PATH. You can install a MSP430 toolchain using:"
		eerror "  $ crossdev -t msp430"
		eerror
		die "MSP430 toolchain not found"
	fi
}

src_install() {
	emake PREFIX="${D}"/usr install
}
