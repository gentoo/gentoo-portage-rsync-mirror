# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_watch/mod_watch-4.03-r3.ebuild,v 1.5 2008/02/06 21:10:16 hollow Exp $

inherit apache-module eutils

KEYWORDS="ppc x86"

DESCRIPTION="Bandwidth graphing module for Apache2 with MRTG."
HOMEPAGE="http://www.snert.com/Software/mod_watch/"
SRC_URI="http://www.snert.com/Software/download/${PN}${PV/./}.tgz"
LICENSE="as-is"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}-4.3"

APACHE2_MOD_CONF="77_mod_watch"
APACHE2_MOD_DEFINE="WATCH"

DOCFILES="*.shtml CHANGES.TXT LICENSE.TXT Contrib/*.txt"

need_apache2

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-apache22.patch
}

src_compile() {
	sed -i \
		-e "s:APXS=\\(.*\\):APXS=${APXS} # \\1:" \
		-e "s:APACHECTL=\\(.*\\):APACHECTL=${APACHE_CTL} # \\1:" \
		Makefile.dso || die "Path fixing failed"

	sed -i -e "s:/usr/local/sbin:/usr/sbin:" \
		apache2mrtg.pl || die "Path fixing failed"

	emake -f Makefile.dso build || die "emake failed"
}

src_install() {
	apache-module_src_install
	dosbin apache2mrtg.pl mod_watch.pl Contrib/mod_watch_list.pl
	keepdir /var/lib/${PN}
}
