# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_auth_nufw/mod_auth_nufw-2.2.1.ebuild,v 1.5 2010/06/17 21:59:59 patrick Exp $

EAPI="1"

inherit eutils apache-module

DESCRIPTION="A NuFW authentication module for Apache."
HOMEPAGE="http://software.inl.fr/trac/wiki/EdenWall/mod_auth_nufw"
SRC_URI="http://software.inl.fr/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+mysql postgres"

DEPEND="mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-server )"
RDEPEND="${DEPEND}"

APACHE2_MOD_FILE="mod_auth_nufw.so"
APACHE2_MOD_CONF="50_${PN}"
APACHE2_MOD_DEFINE="AUTH_NUFW"

DOCFILES="doc/mod_auth_nufw.html"

need_apache2_2

pkg_setup() {
	local cnt=0
	use mysql && cnt="$((${cnt} + 1))"
	use postgres && cnt="$((${cnt} + 1))"
	if [[ "${cnt}" -ne 1 ]] ; then
		eerror "You have set ${P} to use multiple SQL engines."
		eerror "I don't know which to use!"
		eerror "You can use /etc/portage/package.use to	set per-package USE flags."
		eerror "Set it so only one SQL engine type, mysql or postgres, is enabled."
		die "Please set only one SQL engine type!"
	fi
}

src_compile() {
	CPPFLAGS="-I$(/usr/bin/apr-1-config --includedir) ${CPPFLAGS}" \
	econf \
		--with-apache22 \
		--with-apxs=${APXS} \
		$(use_with mysql) \
		|| die "econf failed"
	emake || die "emake failed"
}
