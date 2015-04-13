# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ucspi-ssl/ucspi-ssl-0.94.ebuild,v 1.6 2015/04/13 09:44:50 ago Exp $

EAPI=5

inherit eutils fixheadtails qmail

DESCRIPTION="Command-line tools for building SSL client-server applications"
HOMEPAGE="http://www.fehcom.de/ipnet/ucspi-ssl.html"
SRC_URI="http://www.fehcom.de/ipnet/ucspi-ssl/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE="perl"

DEPEND=">=dev-libs/openssl-0.9.6g:="
RDEPEND="${DEPEND}
	sys-apps/ucspi-tcp"

S="${WORKDIR}"/host/superscript.com/net/${P}/src

src_prepare() {
	ht_fix_all
	sed -i -e 's:HOME/command:/usr/bin:' sslcat.sh sslconnect.sh https\@.sh
	sed -i -e 's:auto:gcc:' conf-cc conf-ld

	qmail_set_cc

	echo "/usr/bin" > conf-tcpbin
	echo "/usr/" > home
	echo "/usr/share/ca-certificates/" > conf-cadir
	echo "${QMAIL_HOME}/control/dh1024.pem" > conf-dhfile
}

src_compile() {
	emake -j1
}

src_install() {
	dodoc ../doc/*
	doman ../man/*.*
	dobin sslserver sslclient sslcat sslconnect https\@ || die
	use perl && dobin sslperl
}
