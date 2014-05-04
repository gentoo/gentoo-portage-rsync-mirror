# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/libftd2xx/libftd2xx-1.1.12.ebuild,v 1.1 2014/05/04 11:20:55 hwoarang Exp $

EAPI=5
inherit multilib

MY_P="${PN}${PV}"

DESCRIPTION="Library that allows a direct access to a USB device"
HOMEPAGE="http://www.ftdichip.com/Drivers/D2XX.htm"
SRC_URI="http://www.ftdichip.com/Drivers/D2XX/Linux/${MY_P}.tar.gz"

LICENSE="FTDI LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

QA_PREBUILT="*"

S=${WORKDIR}

src_install() {

	use amd64 && cd "${S}"/release/build/x86_64
	use x86 && cd "${S}"/release/build/i386

	into /opt
	dolib.so ${PN}.so.${PV}
	dosym ${PN}.so.${PV} /opt/$(get_libdir)/${PN}.so.${PV:0:1}
	dosym ${PN}.so.${PV:0:1} /opt/$(get_libdir)/${PN}.so
	insinto /usr/include
	doins "${S}"/release/ftd2xx.h "${S}"/release/WinTypes.h

	dodir /etc/env.d
	echo "LDPATH=\"/opt/$(get_libdir)\"" > ${D}/etc/env.d/50libftd2xx || die
	if use examples ; then
		find sample lib_table '(' -name '*.so' -o -name '*.[oa]' ')' -exec rm -f {} +
		insinto /usr/share/doc/${PF}
		doins -r sample
		insinto /usr/share/doc/${PF}/sample
		doins -r lib_table
	fi

	dodoc "${S}"/release/ReadMe.txt
}
