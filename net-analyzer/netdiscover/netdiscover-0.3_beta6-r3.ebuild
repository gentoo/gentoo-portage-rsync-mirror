# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netdiscover/netdiscover-0.3_beta6-r3.ebuild,v 1.3 2013/07/04 21:25:20 ottxor Exp $

EAPI=5
inherit eutils autotools

MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="An active/passive address reconnaissance tool."
HOMEPAGE="http://nixgeneration.com/~jaime/netdiscover/"
SRC_URI="http://nixgeneration.com/~jaime/netdiscover/releases/${MY_P}.tar.gz
		mirror://gentoo/netdiscover-0.3-beta6-oui-db-update-20091010.patch.bz2"
IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-macos"

DEPEND=">=net-libs/libnet-1.1.2.1-r1
	>=net-libs/libpcap-0.8.3-r1"

S=${WORKDIR}/${MY_P}

DOCS=( AUTHORS ChangeLog README TODO )

src_prepare() {
	epatch "${WORKDIR}"/netdiscover-0.3-beta6-oui-db-update-20091010.patch
	sed '/char tmac/{s:6:7:}' -i src/misc.c || die #, drop in beta7
	# Avoid installation of ChangeLog, LICENSE, etc. We do this ourselves.
	sed -i \
		-e 's:netdiscoverdoc:noinst:' \
		Makefile.am || die
	sed -i \
		-e 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:g' \
		-e '/AM_PROG_CC_STDC/d' \
		configure.in || die
	eautoreconf
}
