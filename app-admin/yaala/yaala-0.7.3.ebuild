# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/yaala/yaala-0.7.3.ebuild,v 1.2 2013/03/13 21:45:55 tomwij Exp $

EAPI="5"

DESCRIPTION="Yet Another Log Analyzer"
HOMEPAGE="http://www.yaala.org/"
SRC_URI="http://www.yaala.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

src_install() {
	dobin yaala

	exeinto /usr/lib64/perl5/vendor_perl/Yaala/
	doexe lib/Yaala/*.pm

	dodoc AUTHORS CHANGELOG README{,.persistency,.selections}

	insinto /usr/share/yaala
	doins reports {,webserver.}config sample_configs

	insinto /etc/logrotate.d
	doins packaging/yaala.cron yaala
}

pkg_postinst() {
	elog "Example configuration files can be found in /usr/share/yaala."
}
