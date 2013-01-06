# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/pgbouncer/pgbouncer-1.5.3.ebuild,v 1.1 2012/11/13 02:54:25 titanofold Exp $

EAPI="4"

inherit eutils user

RESTRICT="test"

DESCRIPTION="Lightweight connection pooler for PostgreSQL"
HOMEPAGE="http://pgfoundry.org/projects/pgbouncer/"
SRC_URI="http://pgfoundry.org/frs/download.php/3369/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="dev-libs/libevent"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup pgbouncer
	enewuser pgbouncer -1 -1 -1 pgbouncer
}

src_prepare() {
	local rundir=""
	[[ ! -d /run ]] && rundir="/var"

	sed -i -e "s,${PN}.log,/var/log/${PN}/${PN}.log," \
		-e "s,${PN}.pid,/var/run/${PN}/${PN}.pid," \
		-e "s,etc/userlist.txt,/etc/userlist.txt," \
		-e "s,;unix_socket_dir = /tmp,unix_socket_dir = ${rundir}/run/${PN}.sock," \
		"${S}"/etc/pgbouncer.ini || die
}

src_configure() {
	# --enable-debug is only used to disable stripping
	econf \
		--enable-debug \
		$(use_enable debug cassert) \
		--docdir=/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install

	insinto /etc
	newins etc/pgbouncer.ini pgbouncer.conf
	newinitd "${FILESDIR}"/pgbouncer.initd "${PN}"

	dodoc README NEWS AUTHORS
	dodoc doc/*.txt

	dodir /var/log/pgbouncer/
	fowners pgbouncer:pgbouncer /var/log/pgbouncer/
}

pkg_postinst() {
	einfo "Please read the config.txt for Configuration Directives"
	einfo
	einfo "For Administration Commands, see:"
	einfo "    man pgbouncer"
	einfo
	einfo "By default, PgBouncer does not have access to any database."
	einfo "GRANT the permissions needed for your application and make sure that it"
	einfo "exists in PgBouncer's auth_file."
}
