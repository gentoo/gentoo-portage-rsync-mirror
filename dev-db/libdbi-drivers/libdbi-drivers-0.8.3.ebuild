# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/libdbi-drivers/libdbi-drivers-0.8.3.ebuild,v 1.20 2010/09/28 17:22:52 robbat2 Exp $

inherit eutils autotools

MY_PV="${PV}-1"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="The libdbi-drivers project maintains drivers for libdbi."
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://libdbi-drivers.sourceforge.net/"
LICENSE="LGPL-2.1"
DEPEND=">=dev-db/libdbi-0.8.3
		mysql? ( virtual/mysql )
		postgres? ( dev-db/postgresql-base )
		sqlite? ( <dev-db/sqlite-3 )
		sqlite3? ( >=dev-db/sqlite-3 )
		!bindist? ( firebird? ( dev-db/firebird ) )
		doc? ( app-text/openjade )"

IUSE="mysql postgres sqlite oci8 firebird sqlite3 bindist doc"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
SLOT=0
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PN}-0.8.3-doc-build-fix.patch
	epatch "${FILESDIR}"/${PN}-0.8.3-oracle-build-fix.patch
	epatch "${FILESDIR}"/${PN}-0.8.3-firebird-fix.patch
	cd "${S}"
	eautoreconf
}

pkg_setup() {
	local drivers=""
	use mysql && drivers="${drivers} mysql"
	use postgres && drivers="${drivers} pgsql"
	use sqlite && drivers="${drivers} sqlite"
	use sqlite3 && drivers="${drivers} sqlite3"
	if use firebird; then
		if use bindist; then
			eerror "The Interbase Public License is incompatible with LGPL, see bug #200284."
			eerror "Disabling firebird in the build"
		else
			drivers="${drivers} firebird"
		fi
	fi
	if use oci8; then
		if [ -z "${ORACLE_HOME}" ]; then
			die "\$ORACLE_HOME is not set!"
		fi
		drivers="${drivers} oracle"
	fi
	# safety check
	if [ -z "${drivers// /}" ]; then
		die "No supported databases in your USE flags! (mysql, postgres, sqlite, sqlite3, oracle, firebird)"
	fi
}

src_compile() {
	local myconf=""
	# WARNING: the configure script does NOT work correctly
	# --without-$driver does NOT work
	# so do NOT use `use_with...`
	use mysql && myconf="${myconf} --with-mysql"
	use postgres && myconf="${myconf} --with-pgsql"
	use sqlite && myconf="${myconf} --with-sqlite"
	use sqlite3 && myconf="${myconf} --with-sqlite3"
	use !bindist && use firebird && myconf="${myconf} --with-firebird"
	if use oci8; then
		if [ -z "${ORACLE_HOME}" ]; then
			die "\$ORACLE_HOME is not set!"
		fi
		myconf="${myconf} --with-oracle-dir=${ORACLE_HOME} --with-oracle"
	fi

	econf $(use_enable doc docs) ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README README.osx TODO
}
src_test() {
	if [ -z "${WANT_INTERACTIVE_TESTS}" ]; then
		ewarn "Tests disabled due to interactivity."
		ewarn "Run with WANT_INTERACTIVE_TESTS=1 if you want them."
		return 0
	fi
	einfo "Running interactive tests"
	emake check || die "Tests failed"
}
