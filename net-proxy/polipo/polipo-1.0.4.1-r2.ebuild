# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/polipo/polipo-1.0.4.1-r2.ebuild,v 1.1 2013/05/02 19:45:58 tomwij Exp $

EAPI="5"

inherit eutils toolchain-funcs user

DESCRIPTION="A caching web proxy"
HOMEPAGE="http://www.pps.jussieu.fr/~jch/software/polipo/"
SRC_URI="http://www.pps.jussieu.fr/~jch/software/files/${PN}/${P}.tar.gz"
SRC_URI="http://freehaven.net/~chrisd/${PN}/${P}.tar.gz"

LICENSE="MIT GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="sys-apps/texinfo"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/cache/${PN} ${PN}
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-dns-timeout-fix.patch
}

src_compile() {
	tc-export CC
	emake PREFIX=/usr "CDEBUGFLAGS=${CFLAGS}" all
}

src_install() {
	einstall PREFIX=/usr MANDIR=/usr/share/man INFODIR=/usr/share/info "TARGET=${D}"

	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	insinto /etc/${PN} ; doins "${FILESDIR}/config"
	exeinto /etc/cron.daily ; newexe "${FILESDIR}/${PN}.crond" ${PN}.sh

	diropts -m0750 -o ${PN} -g ${PN}
	keepdir /var/cache/${PN}

	dodoc CHANGES README
	dohtml html/*
}

pkg_postinst() {
	einfo "Do not forget to read the manual."
	einfo "Change the config file in /etc/${PN} to suit your needs."
}
