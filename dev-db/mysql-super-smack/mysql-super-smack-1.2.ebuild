# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-super-smack/mysql-super-smack-1.2.ebuild,v 1.11 2013/11/07 03:25:47 patrick Exp $

WANT_AUTOMAKE="1.4"

inherit eutils autotools

MY_PN="super-smack"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Benchmarking, stress testing, and load generation tool for MySQL & PostGreSQL."
HOMEPAGE="http://jeremy.zawodny.com/mysql/${MY_PN}/"
SRC_URI="http://jeremy.zawodny.com/mysql/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="mysql postgres"

DEPEND="mysql? ( virtual/mysql )
		postgres? ( dev-db/postgresql-server )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	use !mysql && use !postgres && die "You need to use at least one of USE=mysql or USE=postgres for benchmarking!"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}.destdir.patch"

	eautomake || die "eautomake failed"
}

src_compile() {
	local myconf=""
	use mysql && myconf="${myconf} --with-mysql"
	use postgres && myconf="${myconf} --with-pgsql"
	myconf="${myconf} --with-datadir=/var/tmp/${MY_PN}"
	myconf="${myconf} --with-smacks-dir=/usr/share/${MY_PN}"
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGES INSTALL MANUAL README TUTORIAL
}
