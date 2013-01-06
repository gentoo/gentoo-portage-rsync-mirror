# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bitcoind/bitcoind-0.4.8_rc3.ebuild,v 1.1 2012/10/08 18:04:56 blueness Exp $

EAPI=4

DB_VER="4.8"

inherit db-use eutils versionator

DESCRIPTION="Original Bitcoin crypto-currency wallet for automated services"
HOMEPAGE="http://bitcoin.org/"
SRC_URI="http://gitorious.org/bitcoin/${PN}-stable/archive-tarball/v${PV/_/} -> bitcoin-v${PV}.tgz
	bip16? ( http://luke.dashjr.org/programs/bitcoin/files/bip16/0.4.7-Minimal-support-for-mining-BIP16-pay-to-script-hash-.patch.xz )
	eligius? (
		!bip16? ( http://luke.dashjr.org/programs/bitcoin/files/eligius_sendfee/0.4.5rc1-eligius_sendfee.patch.xz )
	)
"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+bip16 +eligius logrotate ssl upnp"

RDEPEND="
	>=dev-libs/boost-1.41.0
	dev-libs/crypto++
	dev-libs/openssl[-bindist]
	logrotate? (
		app-admin/logrotate
	)
	upnp? (
		net-libs/miniupnpc
	)
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
"
DEPEND="${RDEPEND}
	>=app-shells/bash-4.1
"

S="${WORKDIR}/bitcoin-${PN}-stable"

pkg_setup() {
	local UG='bitcoin'
	enewgroup "${UG}"
	enewuser "${UG}" -1 -1 /var/lib/bitcoin "${UG}"
}

src_prepare() {
	cd src || die
	cp "${FILESDIR}/0.4.2-Makefile.gentoo" "Makefile" || die
	if use bip16; then
		epatch "${WORKDIR}/0.4.7-Minimal-support-for-mining-BIP16-pay-to-script-hash-.patch"
		use eligius && epatch "${FILESDIR}/0.4.4+bip16-eligius_sendfee.patch"
	else
		use eligius && epatch "${WORKDIR}/0.4.5rc1-eligius_sendfee.patch"
	fi
	use logrotate && epatch "${FILESDIR}/0.4.7-reopen_log_file.patch"
}

src_compile() {
	local OPTS=()
	local BOOST_PKG BOOST_VER BOOST_INC

	OPTS+=("CXXFLAGS=${CXXFLAGS}")
	OPTS+=( "LDFLAGS=${LDFLAGS}")

	OPTS+=("DB_CXXFLAGS=-I$(db_includedir "${DB_VER}")")
	OPTS+=("DB_LDFLAGS=-ldb_cxx-${DB_VER}")

	BOOST_PKG="$(best_version 'dev-libs/boost')"
	BOOST_VER="$(get_version_component_range 1-2 "${BOOST_PKG/*boost-/}")"
	BOOST_VER="$(replace_all_version_separators _ "${BOOST_VER}")"
	BOOST_INC="/usr/include/boost-${BOOST_VER}"
	OPTS+=("BOOST_CXXFLAGS=-I${BOOST_INC}")
	OPTS+=("BOOST_LIB_SUFFIX=-${BOOST_VER}")

	use ssl  && OPTS+=(USE_SSL=1)
	use upnp && OPTS+=(USE_UPNP=1)

	cd src || die
	emake "${OPTS[@]}" ${PN}
}

src_install() {
	dobin src/${PN}

	insinto /etc/bitcoin
	newins "${FILESDIR}/bitcoin.conf" bitcoin.conf
	fowners bitcoin:bitcoin /etc/bitcoin/bitcoin.conf
	fperms 600 /etc/bitcoin/bitcoin.conf

	newconfd "${FILESDIR}/bitcoin.confd" ${PN}
	newinitd "${FILESDIR}/bitcoin.initd" ${PN}

	keepdir /var/lib/bitcoin/.bitcoin
	fperms 700 /var/lib/bitcoin
	fowners bitcoin:bitcoin /var/lib/bitcoin/
	fowners bitcoin:bitcoin /var/lib/bitcoin/.bitcoin
	dosym /etc/bitcoin/bitcoin.conf /var/lib/bitcoin/.bitcoin/bitcoin.conf

	dodoc doc/README

	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}/bitcoind.logrotate" bitcoind
	fi
}
