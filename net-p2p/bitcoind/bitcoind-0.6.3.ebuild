# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bitcoind/bitcoind-0.6.3.ebuild,v 1.6 2012/10/29 01:46:15 blueness Exp $

EAPI="4"

DB_VER="4.8"

inherit db-use eutils versionator toolchain-funcs

DESCRIPTION="Original Bitcoin crypto-currency wallet for automated services"
HOMEPAGE="http://bitcoin.org/"
SRC_URI="https://nodeload.github.com/bitcoin/bitcoin/tarball/v${PV/_/} -> bitcoin-v${PV}.tgz
	eligius? ( http://luke.dashjr.org/programs/bitcoin/files/bitcoind/eligius/sendfee/0.6.1-eligius_sendfee.patch.xz )
	logrotate? ( https://github.com/bitcoin/bitcoin/commit/9af080c351c40a4f56d37174253d33a9f4ffdb69.diff -> 0.6.3-reopen_log_file.patch )
"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="+eligius examples logrotate upnp"

RDEPEND="
	>=dev-libs/boost-1.41.0
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

S="${WORKDIR}/bitcoin-bitcoin-bbe1084"

pkg_setup() {
	local UG='bitcoin'
	enewgroup "${UG}"
	enewuser "${UG}" -1 -1 /var/lib/bitcoin "${UG}"
}

src_prepare() {
	cd src || die
	use eligius && epatch "${WORKDIR}/0.6.1-eligius_sendfee.patch"
	use logrotate && epatch "${DISTDIR}/0.6.3-reopen_log_file.patch"
}

src_compile() {
	OPTS=()
	local BOOST_PKG BOOST_VER BOOST_INC

	OPTS+=("DEBUGFLAGS=")
	OPTS+=("CXXFLAGS=${CXXFLAGS}")
	OPTS+=("LDFLAGS=${LDFLAGS}")

	OPTS+=("BDB_INCLUDE_PATH=$(db_includedir "${DB_VER}")")
	OPTS+=("BDB_LIB_SUFFIX=-${DB_VER}")

	BOOST_PKG="$(best_version 'dev-libs/boost')"
	BOOST_VER="$(get_version_component_range 1-2 "${BOOST_PKG/*boost-/}")"
	BOOST_VER="$(replace_all_version_separators _ "${BOOST_VER}")"
	BOOST_INC="/usr/include/boost-${BOOST_VER}"
	OPTS+=("BOOST_INCLUDE_PATH=${BOOST_INC}")
	OPTS+=("BOOST_LIB_SUFFIX=-${BOOST_VER}")

	if use upnp; then
		OPTS+=(USE_UPNP=1)
	else
		OPTS+=(USE_UPNP=)
	fi

	# Workaround for bug #440034
	share/genbuild.sh src/obj/build.h

	cd src || die
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" -f makefile.unix "${OPTS[@]}" ${PN}
}

src_test() {
	cd src || die
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" -f makefile.unix "${OPTS[@]}" test_bitcoin
	./test_bitcoin || die 'Tests failed'
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

	if use examples; then
		docinto examples
		dodoc -r contrib/{bitrpc,pyminer,wallettools}
	fi

	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}/bitcoind.logrotate" bitcoind
	fi
}
