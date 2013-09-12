# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/tt-rss/tt-rss-1.9.ebuild,v 1.2 2013/09/12 08:33:47 tomka Exp $

EAPI=5

inherit user eutils webapp depend.php depend.apache vcs-snapshot

DESCRIPTION="Tiny Tiny RSS - A web-based news feed (RSS/Atom) aggregator using AJAX"
HOMEPAGE="http://tt-rss.org/"
SRC_URI="https://github.com/gothfox/Tiny-Tiny-RSS/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="daemon +mysql postgres"

DEPEND="
	daemon? ( dev-lang/php[mysql?,postgres?,pcntl,curl] )
	!daemon? ( dev-lang/php[mysql?,postgres?,curl] )
"
RDEPEND="${DEPEND}"

REQUIRED_USE="|| ( mysql postgres )"

need_httpd_cgi
need_php_httpd

pkg_setup() {
	webapp_pkg_setup

	if use daemon; then
			enewgroup ttrssd
			enewuser ttrssd -1 /bin/sh /dev/null ttrssd
	fi
}

src_prepare() {
	# Customize config.php so that the right 'DB_TYPE' is already set (according to the USE flag)
	einfo "Customizing config.php..."
	mv config.php{-dist,} || die "Could not rename config.php-dist to config.php."

	if use mysql && ! use postgres; then
			sed -i \
				-e "/define('DB_TYPE',/{s:pgsql:mysql:}" \
				config.php || die
	fi

	sed -i \
		-e "/define('DB_TYPE',/{s:// \(or mysql\):// pgsql \1:}" \
		config.php || die

	# per 462578
	epatch_user
}

src_install() {
	webapp_src_preinst

	insinto "/${MY_HTDOCSDIR}"
	doins -r *
	keepdir "/${MY_HTDOCSDIR}"/feed-icons

	for DIR in cache lock feed-icons; do
			webapp_serverowned -R "${MY_HTDOCSDIR}/${DIR}"
	done

	webapp_configfile "${MY_HTDOCSDIR}"/config.php
	if use daemon; then
			webapp_postinst_txt en "${FILESDIR}"/postinstall-en-with-daemon.txt
			newinitd "${FILESDIR}"/ttrssd.initd-r2 ttrssd
			newconfd "${FILESDIR}"/ttrssd.confd-r1 ttrssd
			insinto /etc/logrotate.d/
			newins "${FILESDIR}"/ttrssd.logrotated ttrssd
	else
			webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	fi

	webapp_src_install
}
