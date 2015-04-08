# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/smplayer2/smplayer2-0.8.0_p20130111.ebuild,v 1.8 2014/04/26 17:36:59 maksbotan Exp $

EAPI="5"
LANGS="bg ca cs da de en_US es et eu fi fr gl hu it ja ka ko ku lt mk nl pl pt pt_BR sk sr sv tr zh_CN zh_TW"
LANGSLONG="ar_SY el_GR ro_RO ru_RU sl_SI uk_UA vi_VN"

inherit cmake-utils fdo-mime gnome2-utils

DESCRIPTION="Qt4 GUI front-end for mplayer2"
HOMEPAGE="https://github.com/lachs0r/SMPlayer2"
SRC_URI="https://rion-overlay.googlecode.com/files/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa x86"
IUSE="dbus debug +download-subs"
for x in ${LANGS}; do
	IUSE="${IUSE} linguas_${x}"
done
for x in ${LANGSLONG}; do
	IUSE="${IUSE} linguas_${x%_*}"
done

DEPEND="
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dbus? ( dev-qt/qtdbus:4 )
	download-subs? ( dev-libs/quazip )
"
RDEPEND="${DEPEND}
	>=media-video/mplayer2-2.0_p20121128[libass,png]
"

src_configure() {
	# linguas
	local langs x
	for x in ${LANGS}; do
		use linguas_${x} && langs+=" ${x}"
	done
	for x in ${LANGSLONG}; do
		use linguas_${x%_*} && langs+=" ${x}"
	done

	local mycmakeargs=(
		-DLINGUAS="${langs}"
		"$(cmake-utils_use dbus ENABLE_DBUS)"
		"$(cmake-utils_use debug DEBUG_OUTPUT)"
		"$(cmake-utils_use download-subs ENABLE_DOWNLOAD_SUBS)"
	)
	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
