# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pmacct/pmacct-0.14.0.ebuild,v 1.1 2012/04/13 15:22:47 jer Exp $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="A network tool to gather IP traffic information"
HOMEPAGE="http://www.pmacct.net/"
SRC_URI="http://www.pmacct.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="64bit debug ipv6 mysql postgres sqlite threads ulog"

RDEPEND="net-libs/libpcap
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-base )
	sqlite? ( =dev-db/sqlite-3* )"
DEPEND="${RDEPEND}"
DOCS=(
	CONFIG-KEYS ChangeLog EXAMPLES FAQS KNOWN-BUGS README TODO TOOLS UPGRADE
	docs/INTERNALS docs/PLUGINS docs/SIGNALS
)

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-0.12.0-gentoo.patch \
		"${FILESDIR}"/${PN}-0.12.5-sin6_addr.patch
}

src_configure() {
	tc-export CC
	econf \
		$(use_enable 64bit) \
		$(use_enable debug) \
		$(use_enable ipv6) \
		$(use_enable mysql) \
		$(use_enable postgres pgsql) \
		$(use_enable sqlite sqlite3) \
		$(use_enable threads) \
		$(use_enable ulog) \
		|| die "econf failed"
}

src_install() {
	default

	for dirname in examples sql; do
		docinto ${dirname}
		dodoc ${dirname}/*
	done

	newinitd "${FILESDIR}"/pmacctd-init.d pmacctd
	newconfd "${FILESDIR}"/pmacctd-conf.d pmacctd

	insinto /etc/pmacctd
	newins examples/pmacctd-imt.conf.example pmacctd.conf
}
