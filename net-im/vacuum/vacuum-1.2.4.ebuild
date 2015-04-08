# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/vacuum/vacuum-1.2.4.ebuild,v 1.2 2014/08/05 18:34:13 mrueg Exp $

EAPI="5"
LANGS="de pl ru uk"

inherit cmake-utils

DESCRIPTION="Qt4 Crossplatform Jabber client"
HOMEPAGE="http://code.google.com/p/vacuum-im"
SRC_URI="https://googledrive.com/host/0B7A5K_290X8-NE5nLUx5Yl9BTkk/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0/1.17" # subslot = libvacuumutils soname version
KEYWORDS="~amd64 ~x86"
PLUGINS=" adiummessagestyle annotations autostatus avatars birthdayreminder bitsofbinary bookmarks captchaforms chatstates clientinfo commands compress console dataforms datastreamsmanager emoticons filemessagearchive filestreamsmanager filetransfer gateways inbandstreams iqauth jabbersearch messagearchiver multiuserchat pepmanager privacylists privatestorage registration remotecontrol rosteritemexchange rostersearch servermessagearchive servicediscovery sessionnegotiation shortcutmanager socksstreams urlprocessor vcard xmppuriqueries"
IUSE="${PLUGINS// / +}"
for x in ${LANGS}; do
	IUSE+=" linguas_${x}"
done

REQUIRED_USE="
	annotations? ( privatestorage )
	avatars? ( vcard )
	birthdayreminder? ( vcard )
	bookmarks? ( privatestorage )
	captchaforms? ( dataforms )
	commands? ( dataforms )
	datastreamsmanager? ( dataforms )
	filemessagearchive? ( messagearchiver )
	filestreamsmanager? ( datastreamsmanager )
	filetransfer? ( filestreamsmanager datastreamsmanager )
	pepmanager? ( servicediscovery )
	registration? ( dataforms )
	remotecontrol? ( commands dataforms )
	servermessagearchive? ( messagearchiver )
	sessionnegotiation? ( dataforms )
"

RDEPEND="
	>=dev-qt/qtcore-4.5:4[ssl]
	>=dev-qt/qtgui-4.5:4
	dev-qt/qtlockedfile
	>=dev-libs/openssl-0.9.8k
	adiummessagestyle? ( >=dev-qt/qtwebkit-4.5:4 )
	net-dns/libidn
	x11-libs/libXScrnSaver
	sys-libs/zlib[minizip]
"
DEPEND="${RDEPEND}"

DOCS="AUTHORS CHANGELOG README TRANSLATORS"

src_prepare() {
	# Force usage of system libraries
	rm -rf src/thirdparty/{idn,minizip,zlib}
}

src_configure() {
	# linguas
	local langs="none;" x
	for x in ${LANGS}; do
		use linguas_${x} && langs+="${x};"
	done

	local mycmakeargs=(
		-DINSTALL_LIB_DIR="$(get_libdir)"
		-DINSTALL_SDK=ON
		-DLANGS="${langs}"
		-DINSTALL_DOCS=OFF
		-DFORCE_BUNDLED_MINIZIP=OFF
	)

	for x in ${PLUGINS}; do
		mycmakeargs+=( "$(cmake-utils_use ${x} PLUGIN_${x})" )
	done

	cmake-utils_src_configure
}
