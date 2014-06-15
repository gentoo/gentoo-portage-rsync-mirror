# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/icinga2/icinga2-2.0.0_beta2.ebuild,v 1.1 2014/06/15 19:49:46 prometheanfire Exp $

EAPI=5
inherit depend.apache eutils cmake-utils toolchain-funcs user versionator

MY_PV=$(replace_version_separator 3 '-')
DESCRIPTION="Nagios Fork - Check daemon, CGIs, docs, IDOutils. Reloaded"
HOMEPAGE="http://icinga.org/icinga2"
SRC_URI="http://github.com/Icinga/icinga2/archive/v${MY_PV}.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+mysql postgres classicui +plugins"

DEPEND="dev-util/cmake
		dev-libs/openssl
		dev-libs/boost
		sys-devel/bison
		sys-devel/flex
		mysql? ( virtual/mysql )
		postgres? ( dev-db/postgresql-base )"

RDEPEND="${DEPEND}
	plugins? ( net-analyzer/nagios-plugins )
	classicui? ( net-analyzer/icinga[web] )"

REQUIRED_USE="|| ( mysql postgres )"

want_apache2

pkg_setup() {
	enewgroup icinga
	enewgroup icingacmd
	enewuser icinga -1 -1 /var/lib/icinga2 "icinga,icingacmd"
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_SYSCONFDIR=/etc
		-DMAKE_INSTALL_LOCALSTATEDIR=/var
	)

	cmake-utils_src_configure
}

src_install() {
	BUILDDIR="${WORKDIR}"/icinga2-${PV}_build
	cd $BUILDDIR

	#if [[ -f Makefile ]] || [[ -f GNUmakefile ]] || [[ -f makefile ]] ; then

		emake DESTDIR="${D}" install
	#fi

	cd "${WORKDIR}"/icinga2-${MY_PV}
	if ! declare -p DOCS >/dev/null 2>&1 ; then
		local d
		for d in README* ChangeLog AUTHORS NEWS TODO CHANGES THANKS BUGS \
				FAQ CREDITS CHANGELOG ; do
			[[ -s "${d}" ]] && dodoc "${d}"
		done
	elif declare -p DOCS | grep -q "^declare -a " ; then
		dodoc "${DOCS[@]}"
	else
		dodoc ${DOCS}
	fi

	if use mysql ; then
		docinto schema
		newdoc "${WORKDIR}"/icinga2-${MY_PV}/components/db_ido_mysql/schema/mysql.sql mysql.sql
		docinto schema/upgrade
		#newdoc "${WORKDIR}"/icinga2-${MY_PV}/components/db_ido_mysql/schema/upgrade/${PV}.sql mysql-upgrade-1.12.0.sql
		newdoc "${WORKDIR}"/icinga2-${MY_PV}/components/db_ido_mysql/schema/upgrade/0.0.11.sql mysql-upgrade-1.12.0.sql
	elif use postgres ; then
		docinto schema
		newdoc "${WORKDIR}"/icinga2-${MY_PV}/components/db_ido_pgsql/schema/pgsql.sql pgsql.sql
		docinto schema/upgrade
		newdoc "${WORKDIR}"/icinga2-${MY_PV}/components/db_ido_pgsql/schema/upgrade/0.0.11.sql pgsql-upgrade-1.12.0.sql
		#newdoc "${WORKDIR}"/icinga2-${MY_PV}/components/db_ido_pgsql/schema/upgrade/${PV}.sql pgsql-upgrade-1.12.0.sql
	fi

	keepdir /etc/icinga2
	keepdir /var/lib/icinga
	keepdir /var/lib/icinga/archives
	keepdir /var/lib/icinga/rw
	keepdir /var/lib/icinga/spool/checkresults
	keepdir /usr/var/lib/icinga2

	fowners icinga:icinga /var/lib/icinga || die "Failed chown of /var/lib/icinga"
	fowners icinga:icinga /usr/var/lib/icinga2 || die "Failed chown of /usr/var/lib/icinga2"
}

pkg_postinst() {
	elog "DB IDO schema upgrade required. http://docs.icinga.org/icinga2/snapshot/chapter-2.html#upgrading-the-mysql-database"
	elog "You will need to update your configuration files, see https://dev.icinga.org/issues/5909"
}
