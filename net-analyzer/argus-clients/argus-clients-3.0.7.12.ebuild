# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/argus-clients/argus-clients-3.0.7.12.ebuild,v 1.2 2013/08/17 15:59:04 jer Exp $

EAPI=5
inherit autotools eutils toolchain-funcs

DESCRIPTION="Clients for net-analyzer/argus"
HOMEPAGE="http://www.qosient.com/argus/"
SRC_URI="http://qosient.com/argus/dev/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug ft geoip mysql sasl tcpd"

MY_CDEPEND="
	net-analyzer/rrdtool[perl]
	net-libs/libpcap
	sys-libs/ncurses
	sys-libs/readline
	ft? ( net-analyzer/flow-tools )
	geoip? ( dev-libs/geoip )
	mysql? ( virtual/mysql )
	sasl? ( dev-libs/cyrus-sasl )
"

RDEPEND="
	${MY_CDEPEND}
"

DEPEND="
	${MY_CDEPEND}
	sys-devel/bison
	sys-devel/flex
"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-3.0.4.1-disable-tcp-wrappers-automagic.patch

	sed -i -e 's| ar | $(AR) |g' common/Makefile.in || die
	tc-export AR RANLIB

	eautoreconf
}

src_configure() {
	use debug && touch .debug
	econf \
		$(use_with ft libft) \
		$(use_with geoip GeoIP /usr/) \
		$(use_with sasl) \
		$(use_with tcpd wrappers) \
		$(use_with mysql)
}

src_compile() {
	emake CCOPT="${CFLAGS} ${LDFLAGS}" RANLIB=$(tc-getRANLIB)
}

src_install() {
	# argus_parse.a and argus_common.a are supplied by net-analyzer/argus
	dobin bin/ra*
	dodoc ChangeLog CREDITS README CHANGES
	doman man/man{1,5}/*
}
