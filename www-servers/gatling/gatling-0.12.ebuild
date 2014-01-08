# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/gatling/gatling-0.12.ebuild,v 1.4 2014/01/08 06:08:34 vapier Exp $

inherit eutils user

DESCRIPTION="High performance web server"
HOMEPAGE="http://www.fefe.de/gatling/"
SRC_URI="http://dl.fefe.de/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# We still have compile issues with USE=ssl, so it's commented out for now
#IUSE="ssl"
IUSE=""

DEPEND=">=dev-libs/libowfat-0.25
	dev-libs/dietlibc"
	#ssl? ( dev-libs/openssl )
	#"
RDEPEND=""

src_unpack() {
	unpack $A
	cd "${S}"

	epatch "${FILESDIR}/${P}-FLAGS.patch"
}

src_compile() {
	# FIX ME
	#if use ssl; then
	#	emake tlsgatling || die "emake tlsgatling failed"
	#fi
	emake gatling || die "emake gatling failed"
}

src_install() {
	dobin gatling || die "installing gatling binary failed"
	doman gatling.1 || die "installing manpage failed"
	# FIX ME
	#dobin tlsgatling || die "installing tlsgatling binary failed"

	newconfd "${FILESDIR}/gatling.confd" gatling
	newinitd "${FILESDIR}/gatling.initd" gatling
	dodoc README.{ftp,http} || die "installing docs failed"
}

pkg_setup() {
	ebegin "Creating gatling user and group"
	enewgroup gatling
	enewuser ${PN} -1 -1 /var/www/localhost ${PN}
}
