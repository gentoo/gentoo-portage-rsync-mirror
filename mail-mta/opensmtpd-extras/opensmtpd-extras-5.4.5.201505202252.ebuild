# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/opensmtpd-extras/opensmtpd-extras-5.4.5.201505202252.ebuild,v 1.1 2015/05/27 13:15:25 zx2c4 Exp $

EAPI=5

inherit versionator eutils flag-o-matic

DESCRIPTION="Extra tables, filters, and various other addons for OpenSMTPD"
HOMEPAGE="https://github.com/OpenSMTPD/OpenSMTPD-extras"
SRC_URI="https://www.opensmtpd.org/archives/${PN}-$(get_version_component_range 4-).tar.gz"

LICENSE="ISC BSD BSD-1 BSD-2 BSD-4"
SLOT="0"
KEYWORDS="~amd64 ~x86" 
IUSE="filter-dnsbl filter-monkey filter-perl filter-python filter-stub filter-trace filter-void queue-null queue-python queue-ram queue-stub table-ldap table-mysql table-postgres table-redis table-socketmap table-passwd table-python table-sqlite scheduler-ram scheduler-stub scheduler-python"

DEPEND="mail-mta/opensmtpd
	filter-python? ( dev-lang/python:2.7 )
	filter-perl? ( dev-lang/perl )
	table-sqlite? ( dev-db/sqlite:3 )
	table-mysql? ( virtual/mysql )
	table-postgres? ( dev-db/postgresql )
	table-redis? ( dev-libs/hiredis )
	table-python? ( dev-lang/python:2.7 )
	scheduler-python? ( dev-lang/python:2.7 )
	queue-python? ( dev-lang/python:2.7 )
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-$(get_version_component_range 4-)

src_prepare() {
	epatch "${FILESDIR}/${PN}-libevent-version-macro.patch"
}

src_configure() {
	if use filter-python || use queue-python || use table-python || use scheduler-python; then
		# FIXME: clean this up
		append-cppflags "-I/usr/include/python2.7"
	fi

	tc-export AR
	AR="$(which "$AR")" econf \
		--with-privsep-user=smtpd \
		--with-privsep-path=/var/empty \
		--sysconfdir=/etc/opensmtpd \
		$(use_with filter-dnsbl) \
		$(use_with filter-monkey) \
		$(use_with filter-perl) \
		$(use_with filter-python) \
		$(use_with filter-stub) \
		$(use_with filter-trace) \
		$(use_with filter-void) \
		$(use_with queue-null) \
		$(use_with queue-python) \
		$(use_with queue-ram) \
		$(use_with queue-stub) \
		$(use_with table-ldap) \
		$(use_with table-mysql) \
		$(use_with table-postgres) \
		$(use_with table-redis) \
		$(use_with table-socketmap) \
		$(use_with table-passwd) \
		$(use_with table-python) \
		$(use_with table-sqlite) \
		$(use_with scheduler-ram) \
		$(use_with scheduler-stub) \
		$(use_with scheduler-python)
}
