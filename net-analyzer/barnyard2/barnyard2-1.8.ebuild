# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/barnyard2/barnyard2-1.8.ebuild,v 1.4 2011/04/02 12:54:23 ssuominen Exp $

inherit eutils

DESCRIPTION="Parser for Snort unified/unified2 files"
HOMEPAGE="http://www.securixlive.com/barnyard2/"
SRC_URI="http://www.securixlive.com/download/barnyard2/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="static debug aruba gre mpls prelude ipv6 mysql odbc postgres"

DEPEND="net-libs/libpcap
	    mysql? ( virtual/mysql )
		postgres? ( dev-db/postgresql-server )
		prelude? ( >=dev-libs/libprelude-0.9.0 )
		odbc? ( dev-db/unixODBC )"

src_unpack() {

	unpack ${A}
	cd "${S}"

}

src_compile() {

	local myconf

	econf \
		$(use_enable !static shared) \
		$(use_enable static) \
		$(use_enable debug) \
		$(use_enable aruba) \
		$(use_enable gre) \
		$(use_enable mpls) \
		$(use_enable prelude) \
		$(use_enable ipv6) \
		$(use_with mysql) \
		$(use_with odbc) \
		$(use_with postgres postgresql) \
		--without-oracle \
		${myconf}

	emake || die "make failed"

}

src_install () {

	make DESTDIR="${D}" install || die "make install failed"

	dodir /etc/barnyard2

	# A spool dir is needed to start BY2 and this is the most likely choice.
	dodir /var/log/snort

	# BY2 doesn't write logs to this dir unless a logging type output plugin
	# is chosen, but BY2 will not start without a log dir defined.
	dodir /var/log/barnyard2

	dodoc doc/INSTALL \
		  doc/README \
		  doc/README.aruba \
	      doc/README.database \
		  doc/README.sguil \
		  LICENSE \
		  RELEASE.NOTES

	dodoc schemas/create_db2 \
	      schemas/create_mssql \
		  schemas/create_mysql \
		  schemas/create_oracle.sql \
		  schemas/create_postgresql

	insinto /etc/barnyard2
	newins etc/barnyard2.conf barnyard2.conf.distrib

	einfo "Making changes to barnyard2.conf.distrib."
	sed -i -e "s:^#config interface:config interface:" \
		"${D}etc/barnyard2/barnyard2.conf.distrib" \
		|| die "Failed to update barnyard2.conf.distrib"

	sed -i -e "s:^output alert_fast:#output alert_fast:" \
		"${D}etc/barnyard2/barnyard2.conf.distrib" \
		|| die "Failed to update barnyard2.conf.distrib"

	newconfd "${FILESDIR}/barnyard2.confd" barnyard2 \
		|| die "Failed to add barnyard2.confd"

	newinitd "${FILESDIR}/barnyard2.initd" barnyard2 \
		|| die "Failed to add barnyard2.initd"

}

pkg_postinst() {

	einfo
	einfo "Barnyard2 is a fork of the original barnyard project "
	einfo "(which is no longer under development)."
	einfo
	einfo "Barnyard2 is designed specifically for Snort's new unified2"
	einfo "file format. Barnyard2 is under active development and continues"
	einfo "to adapt based on user feedback."
	elog
	elog "For confiuration options, take a look at..."
	elog
	elog "/etc/barnyard2/barnyard2.conf.distrib"
	elog
	ewarn "The following output plugins are considered 'beta' for ${P}"
	ewarn "So your milage may very if you use them."
	ewarn
	ewarn "alert_arrubaaction"
	ewarn "alert_cef"
	ewarn "alert_prelude"
	ewarn "alert_unixsock"
	ewarn
	ewarn "For a list of stable output plugins see..."
	ewarn
	ewarn "http://www.securixlive.com/barnyard2/index.php"
	ewarn
	ewarn "IMPORTANT:"
	ewarn
	ewarn "The settings for 'INTERFACE=' in /etc/conf.d/barnyard2 and"
	ewarn "for 'config interface' in /etc/barnyard2/barnyard2.conf"
	ewarn "must be the same!! The PID file for barnyard2 takes the form of"
	ewarn "barnyard2_<interface>.pid. If conf.d and barnyard2.conf"
	ewarn "do not match then doing '/etc/init.d/barnyard2 stop' will not work."
	ewarn

}
