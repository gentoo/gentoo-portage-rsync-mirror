# Copyright 2010-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bitcoin-qt/bitcoin-qt-9999.ebuild,v 1.3 2015/01/28 18:46:36 blueness Exp $

EAPI=5

DB_VER="4.8"

LANGS="ach af_ZA ar be_BY bg bs ca ca@valencia ca_ES cmn cs cy da de el_GR en eo es es_CL es_DO es_MX es_UY et eu_ES fa fa_IR fi fr fr_CA gl gu_IN he hi_IN hr hu id_ID it ja ka kk_KZ ko_KR ky la lt lv_LV mn ms_MY nb nl pam pl pt_BR pt_PT ro_RO ru sah sk sl_SI sq sr sv th_TH tr uk ur_PK uz@Cyrl vi vi_VN zh_HK zh_CN zh_TW"
inherit autotools db-use eutils fdo-mime gnome2-utils kde4-functions qt4-r2 git-2 user versionator

MyPV="${PV/_/}"
MyPN="bitcoin"
MyP="${MyPN}-${MyPV}"

DESCRIPTION="An end-user Qt4 GUI for the Bitcoin crypto-currency"
HOMEPAGE="http://bitcoin.org/"
SRC_URI="
"
EGIT_PROJECT='bitcoin'
EGIT_REPO_URI="git://github.com/bitcoin/bitcoin.git https://github.com/bitcoin/bitcoin.git"

LICENSE="MIT ISC GPL-3 LGPL-2.1 public-domain || ( CC-BY-SA-3.0 LGPL-2.1 )"
SLOT="0"
KEYWORDS=""
IUSE="$IUSE dbus kde +qrcode test upnp"

RDEPEND="
	>=dev-libs/boost-1.52.0[threads(+)]
	dev-libs/openssl:0[-bindist]
	dev-libs/protobuf
	qrcode? (
		media-gfx/qrencode
	)
	upnp? (
		net-libs/miniupnpc
	)
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
	virtual/bitcoin-leveldb
	dev-libs/libsecp256k1
	dev-qt/qtgui:4
	dbus? (
		dev-qt/qtdbus:4
	)
"
DEPEND="${RDEPEND}
	>=app-shells/bash-4.1
"

src_prepare() {
	epatch "${FILESDIR}/0.9.0-sys_leveldb.patch"
	epatch "${FILESDIR}/${PV}-sys_libsecp256k1.patch"
	rm -r src/leveldb src/secp256k1

	local filt= yeslang= nolang=

	for lan in $LANGS; do
		if [ ! -e src/qt/locale/bitcoin_$lan.ts ]; then
			ewarn "Language '$lan' no longer supported. Ebuild needs update."
		fi
	done

	for ts in $(ls src/qt/locale/*.ts)
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
	filt="bitcoin_\\(${filt:2}\\)\\.\(qm\|ts\)"
	sed "/${filt}/d" -i 'src/qt/bitcoin_locale.qrc'
	sed "s/locale\/${filt}/bitcoin.qrc/" -i 'src/Makefile.qt.include'
	einfo "Languages -- Enabled:$yeslang -- Disabled:$nolang"

	eautoreconf
}

src_configure() {
	econf \
		--disable-ccache \
		$(use_with dbus qtdbus)  \
		$(use_with upnp miniupnpc) $(use_enable upnp upnp-default) \
		$(use_with qrcode qrencode)  \
		$(use_enable test tests)  \
		--with-system-leveldb  \
		--without-utils --without-daemon \
		--without-libs \
		--with-gui
}

src_test() {
	emake check
}

src_install() {
	emake DESTDIR="${D}" install

	rm "${D}/usr/bin/test_bitcoin"

	insinto /usr/share/pixmaps
	newins "share/pixmaps/bitcoin.ico" "${PN}.ico"
	make_desktop_entry "${PN} %u" "Bitcoin-Qt" "/usr/share/pixmaps/${PN}.ico" "Qt;Network;P2P;Office;Finance;" "MimeType=x-scheme-handler/bitcoin;\nTerminal=false"

	dodoc doc/README.md doc/release-notes.md
	dodoc doc/assets-attribution.md doc/tor.md
	doman contrib/debian/manpages/bitcoin-qt.1

	if use kde; then
		insinto /usr/share/kde4/services
		doins contrib/debian/bitcoin-qt.protocol
	fi
}

update_caches() {
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
	buildsycoca
}

pkg_postinst() {
	update_caches
}

pkg_postrm() {
	update_caches
}
