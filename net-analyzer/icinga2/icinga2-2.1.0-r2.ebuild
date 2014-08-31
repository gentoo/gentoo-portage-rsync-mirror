# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/icinga2/icinga2-2.1.0-r2.ebuild,v 1.1 2014/08/30 23:38:04 prometheanfire Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )
inherit depend.apache distutils-r1 eutils cmake-utils toolchain-funcs user versionator systemd

DESCRIPTION="Distributed, general purpose, network monitoring engine"
HOMEPAGE="http://icinga.org/icinga2"
#PV=$(replace_version_separator 3 '-')
SRC_URI="http://github.com/Icinga/icinga2/archive/v${PV}.tar.gz -> ${P}.tar.gz"
#S="${WORKDIR}/${PN}-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+mysql postgres classicui +plugins"

DEPEND="dev-util/cmake
		dev-python/setuptools[${PYTHON_USEDEP}]
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
		-DCMAKE_VERBOSE_MAKEFILE=ON
		-DCMAKE_BUILD_TYPE=None
		-DCMAKE_INSTALL_PREFIX=/usr
		-DCMAKE_INSTALL_SYSCONFDIR=/etc
		-DCMAKE_INSTALL_LOCALSTATEDIR=/var
		-DICINGA2_SYSCONFIGFILE=/etc/conf.d/icinga2
		-DICINGA2_USER=icinga
		-DICINGA2_GROUP=icingacmd
		-DICINGA2_COMMAND_USER=icinga
		-DICINGA2_COMMAND_GROUP=icingacmd
		-DINSTALL_SYSTEMD_SERVICE_AND_INITSCRIPT=yes
	)
	cmake-utils_src_configure
}

src_install() {
	BUILDDIR="${WORKDIR}"/icinga2-${PV}_build
	cd $BUILDDIR

	#if [[ -f Makefile ]] || [[ -f GNUmakefile ]] || [[ -f makefile ]] ; then

		emake DESTDIR="${D}" install
	#fi

	cd "${WORKDIR}"/icinga2-${PV}
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
		newdoc "${WORKDIR}"/icinga2-${PV}/components/db_ido_mysql/schema/mysql.sql mysql.sql
		docinto schema/upgrade
		#newdoc "${WORKDIR}"/icinga2-${PV}/components/db_ido_mysql/schema/upgrade/0.0.11.sql mysql-upgrade-1.12.0.sql
	elif use postgres ; then
		docinto schema
		newdoc "${WORKDIR}"/icinga2-${PV}/components/db_ido_pgsql/schema/pgsql.sql pgsql.sql
		docinto schema/upgrade
		#newdoc "${WORKDIR}"/icinga2-${PV}/components/db_ido_pgsql/schema/upgrade/0.0.11.sql pgsql-upgrade-1.12.0.sql
	fi

	keepdir /etc/icinga2
	keepdir /var/lib/icinga
	keepdir /var/lib/icinga/archives
	keepdir /var/lib/icinga/rw
	keepdir /var/lib/icinga/spool/checkresults

	#remove dirs that shouldn't be installed
	rm -r "${D}var/run" || die "failed to remove  /var/run"
	rm -r "${D}var/cache" || die "failed to remove /var/cache"

	fowners icinga:icinga /var/lib/icinga || die "Failed chown of /var/lib/icinga"
	fowners icinga:icinga /var/lib/icinga2 || die "Failed chown of /var/lib/icinga2"
}

pkg_postinst() {
	elog "DB IDO schema upgrade required. http://docs.icinga.org/icinga2/snapshot/chapter-2.html#upgrading-the-mysql-database"
	elog "You will need to update your configuration files, see https://dev.icinga.org/issues/5909"
}
