# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fcitx-rime/fcitx-rime-0.2.0.ebuild,v 1.3 2013/09/02 08:06:08 ago Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="Rime support for Fcitx"
HOMEPAGE="http://fcitx-im.org/"
SRC_URI="https://fcitx.googlecode.com/files/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=app-i18n/fcitx-4.2.7
	app-i18n/librime
	app-i18n/rime-data
	x11-libs/libnotify"
DEPEND="${RDEPEND}"

src_prepare() {
	# dont build data resource here, already provided by app-i18n/rime-data
	sed -i -e 's|add_subdirectory(data)||' CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DRIME_DATA_DIR=/usr/share/rime-data
	)
	cmake-utils_src_configure
}
