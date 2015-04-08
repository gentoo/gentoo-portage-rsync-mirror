# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_qos/mod_qos-8.18.ebuild,v 1.2 2012/10/12 08:29:44 patrick Exp $

EAPI="2"

inherit apache-module

DESCRIPTION="A QOS module for the apache webserver"
HOMEPAGE="http://mod-qos.sourceforge.net/"
SRC_URI="mirror://sourceforge/mod-qos/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

APXS2_S="${S}/apache2"
APACHE2_MOD_CONF="10_${PN}"
APACHE2_MOD_DEFINE="QOS"

need_apache2_2

src_prepare() {
	sed -i -e '/strip/d' tools/Makefile
}

src_compile() {
	apache-module_src_compile
	emake -C "${S}/tools"
}

src_install() {
	apache-module_src_install
	dobin tools/qslog
	dodoc doc/CHANGES.txt
	rm doc/*.txt
	dohtml doc/*
}
