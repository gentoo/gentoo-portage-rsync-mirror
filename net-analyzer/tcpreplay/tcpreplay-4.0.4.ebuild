# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/tcpreplay/tcpreplay-4.0.4.ebuild,v 1.3 2014/10/30 09:54:08 ago Exp $

EAPI=5
inherit autotools eutils flag-o-matic

DESCRIPTION="a suite of utilities for editing and replaying previously captured network traffic"
HOMEPAGE="http://tcpreplay.appneta.com/"
LICENSE="BSD GPL-3"
SRC_URI="mirror://sourceforge/project/${PN}/${PN}/${PV}/${P}.tar.gz"

SLOT="0"
KEYWORDS="amd64 ~sparc x86"
IUSE="debug pcapnav +tcpdump"

DEPEND="
	>=sys-devel/autogen-5.16.2[libopts]
	dev-libs/libdnet
	>=net-libs/libpcap-0.9
	tcpdump? ( net-analyzer/tcpdump )
	pcapnav? ( net-libs/libpcapnav )
"

RDEPEND="${DEPEND}"

DOCS=( README docs/{CHANGELOG,CREDIT,HACKING,TODO} )

src_prepare() {
	sed -i \
		-e '/CFLAGS=/s|-ggdb -std=gnu99|-std=gnu99|g' \
		-e 's|-O3||g' \
		-e 's|AM_CONFIG_HEADER|AC_CONFIG_HEADERS|g' \
		configure.ac || die
	sed -i \
		-e 's|#include <dnet.h>|#include <dnet/eth.h>|g' \
		src/common/sendpacket.c || die
	sed -i \
		-e 's|@\([A-Z_]*\)@|$(\1)|g' \
		-e '/tcpliveplay_CFLAGS/s|$| $(LDNETINC)|g' \
		-e '/tcpliveplay_LDADD/s|$| $(LDNETLIB)|g' \
		src/Makefile.am || die

	eautoreconf
}

src_configure() {
	# By default it uses static linking. Avoid that, bug 252940
	econf \
		$(use_enable debug) \
		$(use_with pcapnav pcapnav-config /usr/bin/pcapnav-config) \
		$(use_with tcpdump tcpdump /usr/sbin/tcpdump) \
		--disable-local-libopts \
		--enable-dynamic-link \
		--enable-shared \
		--with-libdnet \
		--with-testnic2=lo \
		--with-testnic=lo
}

src_test() {
	if [[ ! ${EUID} -eq 0 ]]; then
		ewarn "Some tests were disabled due to FEATURES=userpriv"
		ewarn "To run all tests issue the following command as root:"
		ewarn " # make -C ${S}/test"
		make -C test tcpprep || die "self test failed - see ${S}/test/test.log"
	else
		make test || {
			ewarn "Note, that some tests require eth0 iface to be UP." ;
			die "self test failed - see ${S}/test/test.log" ; }
	fi
}
