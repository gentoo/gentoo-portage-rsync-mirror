# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/hiawatha/hiawatha-9.5.ebuild,v 1.3 2014/05/23 17:17:42 hasufell Exp $

EAPI=5

CMAKE_MIN_VERSION="2.8.4"

inherit cmake-utils user

DESCRIPTION="Advanced and secure webserver"
HOMEPAGE="http://www.hiawatha-webserver.org"
SRC_URI="http://www.hiawatha-webserver.org/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +cache ipv6 monitor +rewrite rproxy ssl tomahawk +xslt"

RDEPEND="
	ssl? ( >=net-libs/polarssl-1.3 )
	xslt? ( dev-libs/libxml2
			dev-libs/libxslt )"

DEPEND="${RDEPEND}"
PDEPEND="monitor? ( www-apps/hiawatha-monitor )"

# set this in make.conf if you want to use a different user/group
HIAWATHA_USER=${HIAWATHA_USER:-hiawatha}
HIAWATHA_GROUP=${HIAWATHA_GROUP:-hiawatha}

pkg_setup() {
	enewgroup ${HIAWATHA_GROUP}
	enewuser ${HIAWATHA_USER} -1 -1 /var/www/hiawatha ${HIAWATHA_GROUP}
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-9.5-cflags.patch

	rm -r polarssl || die

	grep '#ServerId =' config/hiawatha.conf.in 1>/dev/null || die
	sed -i \
		-e "s/#ServerId =.*$/ServerId = ${HIAWATHA_USER}/" \
		config/hiawatha.conf.in || die
}

src_configure() {
	local mycmakeargs=(
		-DCONFIG_DIR:STRING=/etc/hiawatha
		$(cmake-utils_use_enable cache CACHE)
		$(cmake-utils_use_enable debug DEBUG)
		$(cmake-utils_use_enable ipv6 IPV6)
		$(cmake-utils_use_enable kernel_linux LOADCHECK)
		$(cmake-utils_use_enable monitor MONITOR)
		$(cmake-utils_use_enable rproxy RPROXY)
		$(cmake-utils_use_enable ssl SSL)
		$(cmake-utils_use_enable tomahawk TOMAHAWK)
		$(cmake-utils_use_enable rewrite TOOLKIT)
		$(cmake-utils_use_enable xslt XSLT)
		-DLOG_DIR:STRING=/var/log/hiawatha
		-DPID_DIR:STRING=/var/run
		-DUSE_SHARED_POLARSSL_LIBRARY=ON
		-DUSE_SYSTEM_POLARSSL=ON
		-DWEBROOT_DIR:STRING=/var/www/hiawatha
		-DWORK_DIR:STRING=/var/lib/hiawatha
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	rm -rf "${ED%%/}"/var/www/hiawatha/*

	newinitd "${FILESDIR}"/hiawatha.initd hiawatha

	local i
	for i in /var/{lib,log}/hiawatha ; do
		keepdir ${i}
		fowners ${HIAWATHA_USER}:${HIAWATHA_GROUP} ${i}
		fperms 0750 ${i}
	done

	keepdir /var/www/hiawatha
	fowners ${HIAWATHA_USER}:${HIAWATHA_GROUP} /var/www/hiawatha
}
