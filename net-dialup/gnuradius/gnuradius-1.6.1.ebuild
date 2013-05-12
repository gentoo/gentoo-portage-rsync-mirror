# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gnuradius/gnuradius-1.6.1.ebuild,v 1.3 2013/05/12 03:58:40 patrick Exp $

EAPI="2"

inherit eutils pam

MY_P="${P#gnu}"

DESCRIPTION="GNU radius authentication server"
HOMEPAGE="http://www.gnu.org/software/radius/radius.html"
SRC_URI="mirror://gnu/radius/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="guile mysql postgres odbc dbm nls snmp pam static debug readline"

DEPEND="!net-dialup/freeradius
	!net-dialup/cistronradius
	guile? ( >=dev-scheme/guile-1.4 )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-server )
	odbc? ( || ( dev-db/unixODBC dev-db/libiodbc ) )
	readline? ( sys-libs/readline )
	dbm? ( sys-libs/gdbm )
	snmp? ( net-analyzer/net-snmp )
	pam? ( virtual/pam )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}/${P}-qa-false-positives.patch"
}

src_configure() {
	local additional_conf=""
	if use pam ; then
		additional_conf="--with-pamdir=$(getpam_mod_dir)"
	fi
	econf --enable-client --disable-maintainer-mode \
		$(use_with guile) \
		$(use_with guile server-guile) \
		$(use_with mysql) \
		$(use_with postgres) \
		$(use_with odbc) \
		$(use_with readline) \
		$(use_enable dbm) \
		$(use_enable nls) \
		$(use_enable snmp) \
		$(use_enable pam) \
		$(use_enable debug) \
		$(use_enable static) \
		${additional_conf} || die "configuration failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"
}
