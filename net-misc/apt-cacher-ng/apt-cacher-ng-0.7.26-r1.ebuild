# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/apt-cacher-ng/apt-cacher-ng-0.7.26-r1.ebuild,v 1.1 2014/06/24 13:20:47 jer Exp $

EAPI=5
inherit cmake-utils eutils user

DESCRIPTION="Yet another implementation of an HTTP proxy for Debian/Ubuntu software packages written in C++"
HOMEPAGE="
	http://www.unix-ag.uni-kl.de/~bloch/acng/
	http://packages.qa.debian.org/a/apt-cacher-ng.html
"
LICENSE="BSD-4 ZLIB public-domain"
SLOT="0"
SRC_URI="mirror://debian/pool/main/a/${PN}/${PN}_${PV}.orig.tar.xz"

KEYWORDS="~amd64 ~x86"
IUSE="doc fuse tcpd"

COMMON_DEPEND="
	app-arch/bzip2
	app-arch/xz-utils
	sys-libs/zlib
"
DEPEND="
	${COMMON_DEPEND}
	dev-util/cmake
"
RDEPEND="
	${COMMON_DEPEND}
	dev-lang/perl
	fuse? ( sys-fs/fuse )
	tcpd? ( sys-apps/tcp-wrappers )
"

PATCHES=(
	"${FILESDIR}"/${P}-CVE-2014-4510.patch
)

pkg_setup() {
	# add new user & group for daemon
	enewgroup ${PN}
	enewuser ${PN} -1 -1 -1 ${PN}
}

src_configure(){
	mycmakeargs="-DCMAKE_INSTALL_PREFIX=/usr"
	if use fuse; then
		mycmakeargs="-DHAVE_FUSE_26=yes ${mycmakeargs}"
	else
		mycmakeargs="-DHAVE_FUSE_26=no ${mycmakeargs}"
	fi
	if use tcpd; then
		mycmakeargs="-DHAVE_LIBWRAP=yes ${mycmakeargs}"
	else
		mycmakeargs="-DHAVE_LIBWRAP=no ${mycmakeargs}"
	fi

	cmake-utils_src_configure
}

src_install() {
	pushd ${CMAKE_BUILD_DIR}
	dosbin ${PN}
	if use fuse; then
		dobin acngfs
	fi
	popd

	newinitd "${FILESDIR}"/initd ${PN}
	newconfd "${FILESDIR}"/confd ${PN}

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/logrotate ${PN}

	doman doc/man/${PN}*
	if use fuse; then
		doman doc/man/acngfs*
	fi

	# Documentation
	dodoc README TODO VERSION INSTALL ChangeLog
	if use doc; then
		dodoc doc/*.pdf
		dohtml doc/html/*
		docinto examples/conf
		dodoc conf/*
	fi

	# perl daily cron script
	dosbin expire-caller.pl
	exeinto /etc/cron.daily
	newexe "${FILESDIR}"/cron.daily ${PN}

	# default configuration
	insinto /etc/${PN}
	newins conf/acng.conf ${PN}.conf
	doins $( echo conf/* | sed 's|conf/acng.conf||g' )

	dodir /var/cache/${PN}
	dodir /var/log/${PN}
	# Some directories must exists
	keepdir /var/log/${PN}
	fowners -R ${PN}:${PN} \
		/etc/${PN} \
		/var/log/${PN} \
		/var/cache/${PN}
}
