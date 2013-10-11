# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgresql-docs/postgresql-docs-9.3.1.ebuild,v 1.1 2013/10/11 08:58:21 patrick Exp $

EAPI="4"

inherit versionator

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~ppc-macos ~x86-solaris"

RESTRICT="test"

DESCRIPTION="PostgreSQL documentation"
HOMEPAGE="http://www.postgresql.org/"
LICENSE="POSTGRESQL"

SLOT="$(get_version_component_range 1-2)"

# Comment the following four lines when not a beta or rc.
#MY_PV="${PV//_}"
#MY_FILE_PV="${SLOT}$(get_version_component_range 4)"
#S="${WORKDIR}/postgresql-${MY_FILE_PV}"
#SRC_URI="mirror://postgresql/source/v${MY_FILE_PV}/postgresql-${MY_FILE_PV}.tar.bz2"

# Comment the following two lines when a beta or rc.
S="${WORKDIR}/postgresql-${PV}"
SRC_URI="mirror://postgresql/source/v${PV}/postgresql-${PV}.tar.bz2"

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
