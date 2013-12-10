# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/geoip/geoip-1.6.0-r1.ebuild,v 1.1 2013/12/10 18:48:19 jer Exp $

EAPI=5
inherit autotools eutils

GEOLITE_URI="http://geolite.maxmind.com/download/geoip/database/"

DESCRIPTION="easily lookup countries by IP addresses, even when Reverse DNS entries don't exist"
HOMEPAGE="https://github.com/maxmind/geoip-api-c"
SRC_URI="
	https://github.com/maxmind/${PN}-api-c/archive/v${PV}.tar.gz -> ${P}.tar.gz
	http://geolite.maxmind.com/download/${PN}/database/GeoLiteCountry/GeoIP.dat.gz
	${GEOLITE_URI}asnum/GeoIPASNum.dat.gz
	city? ( ${GEOLITE_URI}GeoLiteCity.dat.gz )
	ipv6? (
		${GEOLITE_URI}GeoIPv6.dat.gz
		city? ( ${GEOLITE_URI}GeoLiteCityv6-beta/GeoLiteCityv6.dat.gz )
	)
"

# GPL-2 for md5.c - part of libGeoIPUpdate, MaxMind for GeoLite Country db
LICENSE="LGPL-2.1 GPL-2 MaxMind2"
SLOT="0"
KEYWORDS=" ~amd64 ~hppa ~x86 ~x86-fbsd"
IUSE="city ipv6 static-libs"

DEPEND="sys-libs/zlib"
RDEPEND="
	${DEPEND}
	net-misc/geoipupdate
"

S="${WORKDIR}/${PN}-api-c-${PV}"

src_prepare() {
	sed -e 's|yahoo.com|98.139.183.24|g' \
		-i test/country_test_name.txt test/region_test.txt || die

	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default

	dodoc AUTHORS ChangeLog README* TODO

	prune_libtool_files

	insinto /usr/share/GeoIP
	doins "${WORKDIR}"/{GeoIP,GeoIPASNum}.dat
	use city && newins "${WORKDIR}"/GeoLiteCity.dat GeoIPCity.dat

	if use ipv6; then
		doins "${WORKDIR}/GeoIPv6.dat"
		use city && newins "${WORKDIR}"/GeoLiteCityv6.dat GeoIPCityv6.dat
	fi

	newsbin "${FILESDIR}/geoipupdate-r2.sh" geoipupdate.sh
}
