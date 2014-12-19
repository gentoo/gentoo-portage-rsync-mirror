# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/postgresql/postgresql-9.3.ebuild,v 1.2 2014/12/19 04:51:54 patrick Exp $

EAPI=5

DESCRIPTION="Virtual package to ease the transition to unified PostgreSQL ebuilds"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="${PV}"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~ppc-macos ~x86-solaris"
IUSE="kerberos ldap +server threads"

DEPEND="
	|| (
		(
			dev-db/postgresql-base:${SLOT}[kerberos=,ldap=,threads=]
			server? ( dev-db/postgresql-server:${SLOT} )
		)
		dev-db/postgresql:${SLOT}[kerberos=,ldap=,server=,threads=]
	)
"
RDEPEND="${DEPEND}"
