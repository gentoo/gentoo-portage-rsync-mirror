# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ntopng/ntopng-1.2.1.ebuild,v 1.2 2015/03/21 18:56:02 jlec Exp $

EAPI=5

inherit autotools user

DESCRIPTION="Network traffic analyzer with web interface"
HOMEPAGE="http://www.ntop.org/"
SRC_URI="mirror://sourceforge/ntop/${PN}/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-db/sqlite:3=
	dev-libs/geoip
	dev-libs/glib:2="
RDEPEND="${DEPEND}
	dev-db/redis"

pkg_setup() {
	enewuser ntopng
}

src_prepare() {
	eautoreconf
}

src_install() {
	SHARE_NTOPNG_DIR="${EPREFIX}/usr/share/${PN}"
	insinto ${SHARE_NTOPNG_DIR}
	doins -r httpdocs scripts

	dobin ${PN}
	doman ${PN}.8

	newinitd "${FILESDIR}/ntopng.init.d" ntopng
	newconfd "${FILESDIR}/ntopng.conf.d" ntopng

	dodir "/var/lib/ntopng"
	fowners ntopng "${EPREFIX}/var/lib/ntopng"
}

pkg_postinst() {
	elog "ntopng default creadential are user='admin' password='admin'"
}
