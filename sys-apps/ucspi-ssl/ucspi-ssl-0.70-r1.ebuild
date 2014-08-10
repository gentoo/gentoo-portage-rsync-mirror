# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ucspi-ssl/ucspi-ssl-0.70-r1.ebuild,v 1.18 2014/08/10 20:25:24 slyfox Exp $

inherit eutils fixheadtails qmail

DESCRIPTION="Command-line tools for building SSL client-server applications"
HOMEPAGE="http://www.superscript.com/ucspi-ssl/"
SRC_URI="http://www.superscript.com/ucspi-ssl/${P}.tar.gz
		http://www.suspectclass.com/~sgifford/ucspi-tls/files/ucspi-ssl-0.70-ucspitls-0.1.patch"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="perl tls"

DEPEND=">=dev-libs/openssl-0.9.6g
	sys-apps/ucspi-tcp"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/host/superscript.com/net/${P}/src

src_unpack() {
	unpack ${A}
	cd "${S}"

	use tls && epatch "${DISTDIR}"/ucspi-ssl-0.70-ucspitls-0.1.patch

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
	make || die "make failed"
}

src_install() {
	dodoc CHANGES TODO UCSPI-SSL
	dobin sslserver sslclient sslcat sslconnect https\@ || die
	use perl && dobin sslperl
}
