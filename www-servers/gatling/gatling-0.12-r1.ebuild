# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/gatling/gatling-0.12-r1.ebuild,v 1.2 2014/01/08 06:08:34 vapier Exp $

EAPI="4"

inherit eutils toolchain-funcs user

DESCRIPTION="High performance web server"
HOMEPAGE="http://www.fefe.de/gatling/"
SRC_URI="http://dl.fefe.de/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="ssl diet"

DEPEND=">=dev-libs/libowfat-0.25
	diet? ( dev-libs/dietlibc )
	ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

src_prepare() {
	rm Makefile  # leaves GNUmakefile
	epatch "${FILESDIR}/${P}-FLAGS.patch"
}

src_compile() {
	local diet_conf='DIET=env'
	use diet && diet_conf=

	local targets=gatling
	use ssl && targets+=' tlsgatling'

	emake CC="$(tc-getCC)" ${diet_conf} ${targets} \
		|| die "emake ${targets} failed"
}

src_install() {
	doman gatling.1 || die "installing manpage failed"

	newconfd "${FILESDIR}/gatling.confd" gatling || die
	newinitd "${FILESDIR}/gatling.initd" gatling || die
	dodoc README.{ftp,http} || die "installing docs failed"

	dobin gatling || die "installing gatling binary failed"
	use ssl && {
		dobin tlsgatling || die "installing tlsgatling binary failed"
	}
}

pkg_setup() {
	ebegin "Creating gatling user and group"
	enewgroup gatling
	enewuser ${PN} -1 -1 /var/www/localhost ${PN}
}
