# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sagan/sagan-0.2.2_p2-r2.ebuild,v 1.4 2013/03/30 14:57:54 maksbotan Exp $

EAPI=4
AUTOTOOLS_AUTORECONF=1
MY_PV="0.2.2-r2"

inherit eutils autotools-utils user

DESCRIPTION="Sagan is a multi-threaded, real time system and event log monitoring system"
HOMEPAGE="http://sagan.softwink.com/"
SRC_URI="http://sagan.softwink.com/download/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="smtp +mysql postgres prelude snort +lognorm +libdnet +pcap"

DEPEND="virtual/pkgconfig
	${RDEPEND}"

RDEPEND="dev-libs/libpcre
	app-admin/sagan-rules[lognorm?]
	smtp? ( net-libs/libesmtp )
	pcap? ( net-libs/libpcap )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-base )
	prelude? ( dev-libs/libprelude )
	lognorm? ( dev-libs/liblognorm )
	libdnet? ( dev-libs/libdnet )
	snort? ( >=net-analyzer/snortsam-2.50 )
	"

AUTOTOOLS_IN_SOURCE_BUILD=1
DOCS=(AUTHORS ChangeLog FAQ INSTALL README NEWS TODO)
PATCHES=( "${FILESDIR}"/mysql_check.patch )

S="${WORKDIR}/${PN}-${MY_PV}"

pkg_setup() {
	enewgroup sagan
	enewuser sagan -1 -1 /dev/null sagan
}

src_configure() {
	 local myeconfargs=(
		$(use_enable mysql)
		$(use_enable postgres postgresql)
		$(use_enable smtp esmtp)
		$(use_enable prelude )
		$(use_enable lognorm)
		$(use_enable libdnet)
		$(use_enable pcap libpcap)
		$(use_enable snort snortsam)
		)

	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	diropts -g sagan -o sagan -m 775

	dodir /var/log/sagan

	keepdir /var/log/sagan

	touch "${ED}"/var/log/sagan/sagan.log
	chown sagan.sagan "${ED}"/var/log/sagan/sagan.log

	newinitd "${FILESDIR}"/sagan.init sagan
	newconfd "${FILESDIR}"/sagan.confd sagan

	insinto /usr/share/doc/${PF}/examples
	doins -r extra/*
}

pkg_postinst() {
	if use smtp; then
		ewarn "You have enabled smtp use flag. If you plan on using Sagan with"
		ewarn "email, create valid writable home directory for user 'sagan'"
		ewarn "For security reasons it was created with /dev/null home directory"
	fi

	einfo "For configuration assistance see"
	einfo "http://wiki.quadrantsec.com/bin/view/Main/SaganHOWTO"
}
