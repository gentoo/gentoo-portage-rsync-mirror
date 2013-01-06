# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_evasive/mod_evasive-1.10.1.ebuild,v 1.3 2012/10/12 08:01:03 patrick Exp $

inherit apache-module eutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="mod_evasive is an evasive maneuvers module to provide action in the event of an HTTP DoS"
HOMEPAGE="http://www.zdziarski.com/projects/mod_evasive/"
SRC_URI="http://www.zdziarski.com/projects/mod_evasive/${P/-/_}.tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

APACHE2_MOD_CONF="10_${PN}"
APACHE2_MOD_DEFINE="EVASIVE"

need_apache2_2

S="${WORKDIR}"/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv ${PN}20.c ${PN}.c
	sed -i -e 's:evasive20_module:evasive_module:g' ${PN}.c
}

src_install() {
	keepdir /var/log/apache2/evasive
	apache-module_src_install
}
