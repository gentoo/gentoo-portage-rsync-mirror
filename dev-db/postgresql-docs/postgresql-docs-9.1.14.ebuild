# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgresql-docs/postgresql-docs-9.1.14.ebuild,v 1.9 2014/09/17 12:29:58 ago Exp $

EAPI="4"

inherit versionator

KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~ppc-macos ~x86-solaris"

RESTRICT="test"

SLOT="$(get_version_component_range 1-2)"
S="${WORKDIR}/postgresql-${PV}"

DESCRIPTION="PostgreSQL documentation"
HOMEPAGE="http://www.postgresql.org/"
SRC_URI="mirror://postgresql/source/v${PV}/postgresql-${PV}.tar.bz2"
LICENSE="POSTGRESQL"

IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	tar xjf "${DISTDIR}/${A}" -C "${WORKDIR}" "${A%.tar.bz2}/doc"
}

src_install() {
	# Don't use ${PF} here as three packages
	# (dev-db/postgresql-{docs,base,server}) have the same set of docs.
	local mypath=/usr/share/doc/postgresql-${SLOT}

	cd "${S}/doc"

	insinto ${mypath}/html
	doins src/sgml/html/*

	insinto ${mypath}/sgml
	doins src/sgml/*.{sgml,dsl}

	insinto ${mypath}/sgml/ref
	doins src/sgml/ref/*.sgml

	fowners root:0 -R ${mypath}

	dodir /etc/eselect/postgresql/slots/${SLOT}
	echo "postgres_ebuilds=\"\${postgres_ebuilds} ${PF}\"" > \
		"${ED}/etc/eselect/postgresql/slots/${SLOT}/docs"
}
