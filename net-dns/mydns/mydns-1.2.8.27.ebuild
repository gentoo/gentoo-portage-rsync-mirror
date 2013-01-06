# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/mydns/mydns-1.2.8.27.ebuild,v 1.2 2011/05/17 16:09:22 hwoarang Exp $

EAPI="3"
inherit autotools confutils eutils

DESCRIPTION="A DNS-Server which gets its data from a MySQL-/PostgreSQL-database"
HOMEPAGE="http://www.mydns.pl/"
SRC_URI="mirror://sourceforge/mydns-ng/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="alias debug nls mysql postgres ssl static status zlib"

RDEPEND="mysql? ( virtual/mysql )
	nls? ( virtual/libintl )
	postgres? ( dev-db/postgresql-base )
	ssl? ( dev-libs/openssl )
	zlib? ( sys-libs/zlib )
	virtual/libiconv"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	sys-devel/bison"

S="${WORKDIR}/${P%.*}"

pkg_setup() {
	confutils_require_one mysql postgres
}

src_prepare() {
	epatch \
		"${FILESDIR}/${P}-m4.patch" \
		"${FILESDIR}/${P}-gentoo.patch"
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable alias) \
		$(use_enable nls) \
		$(use_enable debug) \
		$(use_with mysql) \
		$(use_with postgres pgsql) \
		$(use_enable static) \
		$(use_enable static static-build) \
		$(use_enable status) \
		$(use_with ssl openssl) \
		$(use_with zlib) \
		--without-included-gettext || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS BUGS ChangeLog NEWS README TODO contrib/admin.php contrib/stats.php contrib/create_domain.pl contrib/fix_rr_serial.pl contrib/MyDNS.pm contrib/README || die

	if use postgres; then
		sed -e 's/__db__/postgresql/g' "${FILESDIR}/mydns.rc6" > "${T}/mydns.rc6" || die
		dodoc QUICKSTART.postgres || die
	fi
	if use mysql; then
		sed -e 's/__db__/mysql/g' "${FILESDIR}/mydns.rc6" > "${T}/mydns.rc6" || die
		dodoc QUICKSTART.mysql README.mysql || die
	fi
	newinitd "${T}/mydns.rc6" mydns || die

	## Avoid file collision
	rm -f "${ED}/usr/share/locale/locale.alias"

	# Install config file
	insinto /etc
	newins mydns.conf mydns.conf || die
	fowners root:root /etc/mydns.conf || die
	fperms 0600 /etc/mydns.conf || die
}

pkg_postinst() {
	if use postgres; then
		elog "# createdb mydns"
		elog "# /usr/sbin/mydns --create-tables | psql mydns"
		elog
		elog "to create the tables in the PostgreSQL-Database."
		elog "For more info see QUICKSTART.postgres."
	fi
	if use mysql; then
		elog "# mysqladmin -u <useruname> -p create mydns"
		elog "# /usr/sbin/mydns --create-tables | mysql -u <username> -p mydns"
		elog
		elog "to create the tables in the MySQL-Database."
		elog "For more info see QUICKSTART.mysql."
	fi
	elog
}
