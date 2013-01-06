# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmrtg/qmrtg-2.1-r1.ebuild,v 1.2 2010/02/12 16:53:58 jer Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A tool to analyze qmail's activity with the goal to graph everything through MRTG."
HOMEPAGE="http://dev.publicshout.org/qmrtg"
SRC_URI="${HOMEPAGE}/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""
RDEPEND="net-analyzer/mrtg"

src_prepare() {
	sed -i analyzers/Makefile.in filters/Makefile.in \
		-e 's|^CFLAGS =|CFLAGS ?=|g' || die "sed failed"

	epatch "${FILESDIR}/mrtg.cfg.patch"
	epatch "${FILESDIR}/qmrtg.conf.sample.patch"
}

src_install () {
	emake install DESTDIR="${D}" || die "emake install failed"
	keepdir /var/lib/qmrtg
	dodoc INSTALL.txt
	if use doc ; then
		docinto txt
		dodoc doc/*.txt
		docinto html
		dohtml -r html/*
	fi

	insinto /usr/share/qmrtg2
	doins examples/*

}

pkg_postinst () {
	elog
	elog "You need to configure manually qmrtg in order to run it."
	elog "The configuration templates in /usr/share/qmrtg2/ and"
	elog "the INSTALL file in /usr/share/doc/qmrtg-2.1/"
	elog "will be useful."
	elog
}
