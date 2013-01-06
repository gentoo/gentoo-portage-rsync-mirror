# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qiviewer/qiviewer-0.5.0.ebuild,v 1.1 2012/09/07 07:05:48 pinkbyte Exp $

EAPI="4"
PLOCALES="el es_AR es_ES"
inherit l10n qt4-r2

DESCRIPTION="Lightweight image viewer, similar to eog or viewnior for Gnome"
HOMEPAGE="http://code.google.com/p/qiviewer"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gif tiff webp"

DEPEND="x11-libs/qt-gui:4[gif=,tiff=]
	webp? ( media-libs/libwebp )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}/src"

src_prepare() {
	local LOCALE_FILES=""
	add_locale() {
		LOCALE_FILES="${LOCALE_FILES} ${1}.ts"
	}

	# Check for locales added/removed from previous version
	l10n_find_plocales_changes "${S}/translations" "" '.ts'
	# Fill list of available locale files
	l10n_for_each_locale_do add_locale
	sed -i -e "s:TRANSLATIONS += .\+:TRANSLATIONS = ${LOCALE_FILES}:" translations/locale.pri || die 'locale sed failed'
	# Fix mime types in desktop file
	sed -i -e "s:^MimeType=\(.\+\)imaqe/x-xpixrnap;\(.\+\):MimeType=\1\2:" qiviewer.desktop || die 'desktop file sed failed'
	# Use system libwebp
	epatch "${FILESDIR}"/${PN}-use-system-webp.patch

	qt4-r2_src_prepare
}

src_configure() {
	local _webp=
	use webp && _webp="CONFIG+=enable-webp"
	eqmake4 ${PN}.pro $_webp
}

src_install() {
	qt4-r2_src_install
	cd "${WORKDIR}"/"${PN}"
	dodoc AUTHORS ChangeLog README
}
