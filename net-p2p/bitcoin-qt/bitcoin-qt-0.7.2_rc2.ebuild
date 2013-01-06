# Copyright 2010-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bitcoin-qt/bitcoin-qt-0.7.2_rc2.ebuild,v 1.1 2012/12/06 13:29:17 blueness Exp $

EAPI=4

DB_VER="4.8"

LANGS="bg ca_ES cs da de el_GR en es es_CL et eu_ES fa fa_IR fi fr fr_CA he hr hu it lt nb nl pl pt_BR pt_PT ro_RO ru sk sr sv tr uk zh_CN zh_TW"
inherit db-use eutils qt4-r2 versionator

DESCRIPTION="An end-user Qt4 GUI for the Bitcoin crypto-currency"
HOMEPAGE="http://bitcoin.org/"
SRC_URI="http://gitorious.org/bitcoin/bitcoind-stable/archive-tarball/v${PV/_/} -> bitcoin-v${PV}.tgz
	1stclassmsg? ( http://luke.dashjr.org/programs/bitcoin/files/bitcoind/luke-jr/1stclassmsg/0.7.1-1stclassmsg.patch.xz )
	eligius? ( http://luke.dashjr.org/programs/bitcoin/files/bitcoind/eligius/sendfee/0.7.1-eligius_sendfee.patch.xz )
"

LICENSE="MIT ISC GPL-3 LGPL-2.1 public-domain || ( CCPL-Attribution-ShareAlike-3.0 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="$IUSE 1stclassmsg dbus +eligius ipv6 +qrcode upnp"

RDEPEND="
	>=dev-libs/boost-1.41.0
	dev-libs/openssl[-bindist]
	qrcode? (
		media-gfx/qrencode
	)
	upnp? (
		net-libs/miniupnpc
	)
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
	x11-libs/qt-gui:4
	dbus? (
		x11-libs/qt-dbus:4
	)
"
DEPEND="${RDEPEND}
	>=app-shells/bash-4.1
"

DOCS="doc/README"

S="${WORKDIR}/bitcoin-bitcoind-stable"

src_prepare() {
	use 1stclassmsg && epatch "${WORKDIR}/0.7.1-1stclassmsg.patch"
	cd src || die
	use eligius && epatch "${WORKDIR}/0.7.1-eligius_sendfee.patch"

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
	local BOOST_PKG BOOST_VER

	use dbus && OPTS+=("USE_DBUS=1")
	if use upnp; then
		OPTS+=("USE_UPNP=1")
	else
		OPTS+=("USE_UPNP=-")
	fi
	use qrcode && OPTS+=("USE_QRCODE=1")
	use 1stclassmsg && OPTS+=("FIRST_CLASS_MESSAGING=1")
	use ipv6 || OPTS+=("USE_IPV6=-")

	OPTS+=("BDB_INCLUDE_PATH=$(db_includedir "${DB_VER}")")
	OPTS+=("BDB_LIB_SUFFIX=-${DB_VER}")

	BOOST_PKG="$(best_version 'dev-libs/boost')"
	BOOST_VER="$(get_version_component_range 1-2 "${BOOST_PKG/*boost-/}")"
	BOOST_VER="$(replace_all_version_separators _ "${BOOST_VER}")"
	OPTS+=("BOOST_INCLUDE_PATH=/usr/include/boost-${BOOST_VER}")
	OPTS+=("BOOST_LIB_SUFFIX=-${BOOST_VER}")

	eqmake4 "${PN}.pro" "${OPTS[@]}"
}

src_compile() {
	# Workaround for bug #440034
	share/genbuild.sh build/build.h

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
