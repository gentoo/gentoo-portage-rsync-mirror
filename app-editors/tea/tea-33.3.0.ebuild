# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/tea/tea-33.3.0.ebuild,v 1.2 2013/01/04 10:35:22 pesa Exp $

EAPI=5
PLOCALES="de fr ru"

inherit eutils l10n qt4-r2

DESCRIPTION="Small, lightweight Qt text editor"
HOMEPAGE="http://tea-editor.sourceforge.net/"
SRC_URI="mirror://sourceforge/tea-editor/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86 ~x86-fbsd"
IUSE="aspell hunspell"

RDEPEND="
	sys-libs/zlib
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	aspell? ( app-text/aspell )
	hunspell? ( app-text/hunspell )
"
DEPEND="${RDEPEND}
	hunspell? ( virtual/pkgconfig )
"

DOCS=(AUTHORS ChangeLog NEWS TODO)

src_configure() {
	eqmake4 src.pro \
		PREFIX="${EPREFIX}/usr/bin" \
		USE_ASPELL=$(use aspell && echo true || echo false) \
		USE_HUNSPELL=$(use hunspell && echo true || echo false)
}

src_install() {
	qt4-r2_src_install

	newicon icons/tea_icon_v2.png ${PN}.png
	make_desktop_entry ${PN} 'Tea Editor'

	# translations
	insinto /usr/share/qt4/translations
	local lang
	for lang in $(l10n_get_locales); do
		doins translations/${PN}_${lang}.qm
	done

	# docs
	dohtml manuals/en.html
	if use linguas_ru; then
		dodoc NEWS-RU
		dohtml manuals/ru.html
	fi
}
