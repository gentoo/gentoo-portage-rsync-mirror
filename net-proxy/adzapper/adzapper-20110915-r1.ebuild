# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/adzapper/adzapper-20110915-r1.ebuild,v 1.1 2012/08/10 14:11:59 jer Exp $

EAPI=4

MY_P=${P/zapper/zap}

DESCRIPTION="Redirector for squid that intercepts advertising, page counters and some web bugs"
HOMEPAGE="http://adzapper.sourceforge.net/"
SRC_URI="http://adzapper.sourceforge.net/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-lang/perl"

S="${WORKDIR}"/${P/per/}

src_prepare() {
	# update the zapper path in various scripts
	local SCRPATH="/etc/adzapper/squid_redirect"
	sed -i scripts/wrapzap scripts/update-zapper* \
		-e "s|^zapper=.*|zapper=${SCRPATH}|" \
		-e "s|^ZAPPER=.*|ZAPPER=\"${SCRPATH}\"|" \
		-e "s|^pidfile=.*|pidfile=/var/run/squid.pid|" \
		-e "s|^PIDFILE=.*|PIDFILE=\"/var/run/squid.pid\"|" \
		-e "s|^RESTARTCMD=.*|RESTARTCMD=\"/etc/init.d/squid restart\"|" \
		|| die "sed updating failed."
}

src_install() {
	exeinto /etc/adzapper
	doexe \
		scripts/wrapzap \
		scripts/zapchain \
		adblock-plus/adblockplus2adzapper.py
	newexe scripts/squid_redirect-nodata squid_redirect

	insinto /etc/adzapper
	doins scripts/update-zapper*

	insinto /var/www/localhost/htdocs/zap
	doins zaps/*
}

pkg_postinst() {
	einfo "To enable adzapper, add the following lines to /etc/squid/squid.conf:"
	einfo "    url_rewrite_program /etc/adzapper/wrapzap"
	einfo "    url_rewrite_children 10"
}
