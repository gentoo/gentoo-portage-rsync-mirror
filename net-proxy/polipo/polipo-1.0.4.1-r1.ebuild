# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/polipo/polipo-1.0.4.1-r1.ebuild,v 1.1 2011/12/31 21:11:37 idl0r Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A caching web proxy"
HOMEPAGE="http://www.pps.jussieu.fr/~jch/software/polipo/"
SRC_URI="http://www.pps.jussieu.fr/~jch/software/files/${PN}/${P}.tar.gz"
SRC_URI="http://freehaven.net/~chrisd/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="sys-apps/texinfo"

pkg_setup() {
	enewgroup polipo
	enewuser polipo -1 -1 /var/cache/polipo polipo
}

src_compile() {
	tc-export CC
	emake PREFIX=/usr "CDEBUGFLAGS=${CFLAGS}" all || die "build failed"
}

src_install() {
	einstall PREFIX=/usr MANDIR=/usr/share/man INFODIR=/usr/share/info "TARGET=${D}" || die "install failed"

	newinitd "${FILESDIR}/polipo.initd" polipo
	insinto /etc/polipo ; doins "${FILESDIR}/config"
	exeinto /etc/cron.daily ; newexe "${FILESDIR}/polipo.crond" polipo.sh

	diropts -m0750 -o polipo -g polipo
	keepdir /var/cache/polipo

	dodoc CHANGES README
	dohtml html/*
}

pkg_postinst() {
	einfo "Do not forget to read the manual."
	einfo "Change the config file in /etc/polipo to suit your needs."
}
