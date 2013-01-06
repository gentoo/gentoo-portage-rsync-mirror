# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/mydns/mydns-1.1.0-r1.ebuild,v 1.9 2010/06/17 21:47:22 patrick Exp $

inherit eutils

DESCRIPTION="A DNS-Server which gets its data from mysql-databases"
HOMEPAGE="http://mydns.bboy.net/"
SRC_URI="http://mydns.bboy.net/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~ppc sparc x86"
IUSE="debug nls postgres ssl static zlib"

RDEPEND="ssl? ( dev-libs/openssl )
	zlib? ( sys-libs/zlib )
	postgres? ( dev-db/postgresql-server )
	!postgres? ( virtual/mysql )"
DEPEND="${RDEPEND}
	sys-devel/bison"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${P}-m4.patch
	epatch "${FILESDIR}"/04-update-smash-fix.dpatch
	autoconf || die
}

src_compile() {
	local myconf

	if ! use postgres; then
		myconf="${myconf} --with-mysql"
	else
		myconf="${myconf} --without-mysql --with-pgsql"
	fi

	econf --enable-alias \
		`use_enable nls` \
		`use_enable debug` \
		`use_enable static static-build` \
		`use_with ssl openssl` \
		`use_with zlib` \
		${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS BUGS ChangeLog NEWS README TODO

	newinitd "${FILESDIR}"/mydns.rc6 mydns || die

	if ! use postgres; then
		sed -i -e 's/__db__/mysql/g' "${D}"/etc/init.d/mydns || die
		dodoc QUICKSTART.mysql README.mysql
	else
		sed -i -e 's/__db__/postgresql/g' "${D}"/etc/init.d/mydns || die
		dodoc QUICKSTART.postgres
	fi
}

pkg_postinst() {
	elog
	elog "You should now run these commands:"
	elog
	elog "# /usr/sbin/mydns --dump-config > /etc/mydns.conf"
	elog "# chmod 0600 /etc/mydns.conf"
	if ! use postgres; then
		elog "# mysqladmin -u <useruname> -p create mydns"
		elog "# /usr/sbin/mydns --create-tables | mysql -u <username> -p mydns"
		elog
		elog "to create the tables in the MySQL-Database."
		elog "For more info see QUICKSTART.mysql."
	else
		elog "# createdb mydns"
		elog "# /usr/sbin/mydns --create-tables | psql mydns"
		elog
		elog "to create the tables in the PostgreSQL-Database."
		elog "For more info see QUICKSTART.postgres."
	fi
	elog
}
