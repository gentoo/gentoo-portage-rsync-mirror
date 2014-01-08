# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/monitorix/monitorix-3.1.0.ebuild,v 1.2 2014/01/08 06:11:54 vapier Exp $

EAPI="5"

inherit eutils user

DESCRIPTION="A lightweight system monitoring tool"
HOMEPAGE="http://www.${PN}.org/"
SRC_URI="http://www.${PN}.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="evms hddtemp httpd lm_sensors postfix"

DEPEND="sys-apps/sed"
RDEPEND="net-analyzer/rrdtool[perl]
	dev-perl/DBI
	dev-perl/libwww-perl
	dev-perl/XML-Simple
	dev-perl/config-general
	dev-perl/HTTP-Server-Simple
	evms? ( sys-fs/evms )
	hddtemp? ( app-admin/hddtemp )
	httpd? ( virtual/httpd-cgi )
	lm_sensors? ( sys-apps/lm_sensors )
	postfix? ( net-mail/pflogsumm )"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN}
}

src_prepare() {
	# Put better Gentoo defaults in the configuration file.
	sed -i "s|\(base_dir.*\)/usr/share/${PN}|\1/usr/share/${PN}/htdocs|" ${PN}.conf
	sed -i "s|\(secure_log.*\)/var/log/secure|\1/var/log/auth.log|" ${PN}.conf
	sed -i "s|nobody|${PN}|g" ${PN}.conf
}

src_install() {
	dosbin ${PN}

	newinitd "${FILESDIR}"/${PN}-3.0.0.init ${PN}

	insinto /etc
	doins ${PN}.conf

	insinto /etc/logrotate.d
	newins docs/${PN}.logrotate ${PN}

	dodoc Changes README{,.nginx} docs/${PN}.service docs/${PN}-{alert.sh,apache.conf,lighttpd.conf}
	doman man/man5/${PN}.conf.5
	doman man/man8/${PN}.8

	insinto /usr/share/${PN}/htdocs
	doins logo_bot.png logo_top.png ${PN}ico.png

	dodir /var/lib/${PN}/imgs
	dosym /var/lib/${PN}/imgs /usr/share/${PN}/htdocs/imgs

	exeinto /usr/share/${PN}/htdocs/cgi
	doexe ${PN}.cgi

	dodir /usr/lib/${PN}
	exeinto /usr/lib/${PN}
	doexe lib/*.pm

	dodir /var/lib/${PN}/usage
	insinto /var/lib/${PN}/reports
	doins -r reports/*
}

pkg_postinst() {
	chown monitorix:monitorix /var/lib/${PN}/imgs

	elog "WARNING: ${PN} includes a brand new config format since version"
	elog "3.0.0, that may be incompatible with your existing config"
	elog "file. Please take care if upgrading from an old version."
	elog ""
	elog "${PN} includes its own web server as of version 3.0.0."
	elog "For this reason, the dependency on the webapp framework"
	elog "has been removed. If you wish to use your own web server,"
	elog "the ${PN} web data can be found at:"
	elog "/usr/share/${PN}/htdocs/"
}
