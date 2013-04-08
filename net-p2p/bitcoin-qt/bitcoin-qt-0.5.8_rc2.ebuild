# Copyright 2010-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bitcoin-qt/bitcoin-qt-0.5.8_rc2.ebuild,v 1.1 2013/04/08 00:08:53 blueness Exp $

EAPI=4

DB_VER="4.8"

LANGS="da de en es es_CL hu it nb nl pt_BR ru uk zh_CN zh_TW"
inherit db-use eutils qt4-r2 versionator

DESCRIPTION="An end-user Qt4 GUI for the Bitcoin crypto-currency"
HOMEPAGE="http://bitcoin.org/"
SRC_URI="http://gitorious.org/bitcoin/bitcoind-stable/archive-tarball/v${PV/_/} -> bitcoin-v${PV}.tgz
	bip16? ( http://luke.dashjr.org/programs/bitcoin/files/bip16/0.5.6-Minimal-support-for-mining-BIP16-pay-to-script-hash-.patch.xz )
"

LICENSE="MIT ISC GPL-3 LGPL-2.1 public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="$IUSE +bip16 dbus ssl upnp"

RDEPEND="
	>=dev-libs/boost-1.41.0[threads(+)]
	dev-libs/openssl[-bindist]
	upnp? (
		net-libs/miniupnpc
	)
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
	dev-qt/qtgui:4
	dbus? (
		dev-qt/qtdbus:4
	)
"
DEPEND="${RDEPEND}
	>=app-shells/bash-4.1
"

DOCS="doc/README"

S="${WORKDIR}/bitcoin-bitcoind-stable"

src_prepare() {
	cd src || die
	if use bip16; then
		epatch "${WORKDIR}/0.5.6-Minimal-support-for-mining-BIP16-pay-to-script-hash-.patch"
	fi

	local filt= yeslang= nolang=

	for lan in $LANGS; do
		if [ ! -e qt/locale/bitcoin_$lan.ts ]; then
			ewarn "Language '$lan' no longer supported. Ebuild needs update."
		fi
	done

	for ts in $(ls qt/locale/*.ts)
	do
		x="${ts/*bitcoin_/}"
		x="${x/.ts/}"
		if ! use "linguas_$x"; then
			nolang="$nolang $x"
			rm "$ts"
			filt="$filt\\|$x"
		else
			yeslang="$yeslang $x"
		fi
	done
	filt="bitcoin_\\(${filt:2}\\)\\.qm"
	sed "/${filt}/d" -i 'qt/bitcoin.qrc'
	einfo "Languages -- Enabled:$yeslang -- Disabled:$nolang"
}

src_configure() {
	OPTS=()

	use dbus && OPTS+=("USE_DBUS=1")
	use ssl  && OPTS+=("DEFINES+=USE_SSL")
	if use upnp; then
		OPTS+=("USE_UPNP=1")
	else
		OPTS+=("USE_UPNP=-")
	fi

	OPTS+=("BDB_INCLUDE_PATH=$(db_includedir "${DB_VER}")")
	OPTS+=("BDB_LIB_SUFFIX=-${DB_VER}")

	eqmake4 "${PN}.pro" "${OPTS[@]}"
}

src_compile() {
	emake
}

src_test() {
	cd src || die
	emake -f makefile.unix "${OPTS[@]}" test_bitcoin
	./test_bitcoin || die 'Tests failed'
}

src_install() {
	qt4-r2_src_install
	dobin ${PN}
	insinto /usr/share/pixmaps
	newins "share/pixmaps/bitcoin.ico" "${PN}.ico"
	make_desktop_entry ${PN} "Bitcoin-Qt" "/usr/share/pixmaps/${PN}.ico" "Network;P2P"
}
