# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_caucho/mod_caucho-4.0.15.ebuild,v 1.3 2014/08/10 20:15:01 slyfox Exp $

EAPI="2"

inherit eutils apache-module autotools

DESCRIPTION="mod_caucho connects Resin and Apache2"
HOMEPAGE="http://www.caucho.com/"
SRC_URI="http://www.caucho.com/download/resin-${PV}-src.zip
	mirror://gentoo/resin-gentoo-patches-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="${DEPEND}
	app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/resin-${PV}"

# See apache-module.eclass for more information.
APACHE2_MOD_CONF="88_${PN}"
APACHE2_MOD_DEFINE="CAUCHO"
APACHE2_MOD_FILE="${S}/modules/c/src/apache2/.libs/${PN}.so"

need_apache2_2

src_prepare() {
	for i in "${WORKDIR}"/${PV}/mod_caucho-*; do
		epatch "${i}"
	done

	mkdir m4
	eautoreconf
	chmod 755 ./configure
}

src_configure() {
	econf --with-apxs=${APXS} || die "econf failed"
}

src_compile() {
	emake -C "${S}/modules/c/src/apache2/" || die "emake failed"
}
