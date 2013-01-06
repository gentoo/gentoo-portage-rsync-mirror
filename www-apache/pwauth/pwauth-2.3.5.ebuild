# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/pwauth/pwauth-2.3.5.ebuild,v 1.1 2008/01/27 18:08:47 hollow Exp $

inherit eutils toolchain-funcs pam

DESCRIPTION="A Unix Web Authenticator"
HOMEPAGE="http://www.unixpapa.com/pwauth/"
SRC_URI="http://www.unixpapa.com/software/${P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="faillog pam ignore-case domain-aware"

DEPEND="pam? ( virtual/pam )"

pkg_setup() {
	local OPTS

	einfo "You can configure various build time options with ENV variables:"
	einfo
	einfo "    PWAUTH_FAILLOG      Path to logfile for login failures"
	einfo "                        (default: /var/log/pwauth.log)"
	einfo "    PWAUTH_SERVERUIDS   Comma seperated list of UIDs allowed to run pwauth"
	einfo "                        (default: 81)"
	einfo "    PWAUTH_MINUID       Minimum UID for which authentication will succeed"
	einfo "                        (default: 1000)"
	einfo

	PWAUTH_FAILLOG="${PWAUTH_FAILLOG:-/var/log/pwauth.log}"
	PWAUTH_SERVERUIDS="${PWAUTH_SERVERUIDS:-81}"
	PWAUTH_MINUID="${PWAUTH_MINUID:-1000}"

	OPTS="${OPTS} -DSERVER_UIDS=${PWAUTH_SERVERUIDS}"
	OPTS="${OPTS} -DMIN_UNIX_UID=${PWAUTH_MINUID}"

	if use faillog; then
		OPTS="${OPTS} -DFAILLOG_PWAUTH"
		OPTS="${OPTS} -DPATH_FAILLOG=\"\\\"${PWAUTH_FAILLOG}\\\"\""
	fi

	if use pam; then
		OPTS="${OPTS} -DPAM"
		LDFLAGS="-lpam"
	else
		OPTS="${OPTS} -DSHADOW_SUN"
		LDFLAGS="-lcrypt"
	fi

	if use ignore-case; then
		OPTS="${OPTS} -DIGNORE_CASE"
	fi

	if use domain-aware; then
		OPTS="${OPTS} -DOMAIN_AWARE"
	fi

	CC=$(tc-getCC)
	CFLAGS="${CFLAGS} ${OPTS}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/pwauth-gentoo.patch
}

src_install() {
	dosbin pwauth unixgroup
	fperms 4755 /usr/sbin/pwauth

	use pam && newpamd "${FILESDIR}"/pwauth.pam-include pwauth

	dodoc CHANGES FORM_AUTH INSTALL README
}
