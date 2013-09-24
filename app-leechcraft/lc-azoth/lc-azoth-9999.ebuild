# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-azoth/lc-azoth-9999.ebuild,v 1.7 2013/09/24 18:10:49 maksbotan Exp $

EAPI="5"

inherit leechcraft

DESCRIPTION="Azoth, the modular IM client for LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug doc astrality +acetamide +adiumstyles +autoidler +autopaste +birthdaynotifier
		+chathistory +crypt +depester +embedmedia +herbicide +hili +isterique
		+juick +keeso +lastseen	+metacontacts media +msn +murm +latex +nativeemoticons
		+otroid +p100q +spell shx +standardstyles +vader +xmpp +xtazy"

COMMON_DEPEND="~app-leechcraft/lc-core-${PV}
		dev-libs/qjson
		dev-qt/qtwebkit:4
		autoidler? ( x11-libs/libXScrnSaver )
		astrality? ( net-libs/telepathy-qt )
		otroid? ( net-libs/libotr )
		media? ( dev-qt/qtmultimedia:4 )
		msn? ( net-libs/libmsn )
		spell? ( app-text/hunspell )
		xmpp? ( =net-libs/qxmpp-9999 media-libs/speex )
		xtazy? (
			app-leechcraft/lc-xtazy
			dev-qt/qtdbus:4
		)
		crypt? ( app-crypt/qca app-crypt/qca-gnupg )"
DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen[dot] )"
RDEPEND="${COMMON_DEPEND}
	astrality? (
		net-im/telepathy-mission-control
		net-voip/telepathy-haze
	)
	latex? (
		|| (
			media-gfx/imagemagick
			media-gfx/graphicsmagick[imagemagick]
		)
		virtual/latex-base
	)"

REQUIRED_USE="|| ( standardstyles adiumstyles )"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable crypt CRYPT)
		$(cmake-utils_use_with doc DOCS)
		$(cmake-utils_use_enable acetamide AZOTH_ACETAMIDE)
		$(cmake-utils_use_enable adiumstyles AZOTH_ADIUMSTYLES)
		$(cmake-utils_use_enable astrality AZOTH_ASTRALITY)
		$(cmake-utils_use_enable autoidler AZOTH_AUTOIDLER)
		$(cmake-utils_use_enable autopaste AZOTH_AUTOPASTE)
		$(cmake-utils_use_enable birthdaynotifier AZOTH_BIRTHDAYNOTIFIER)
		$(cmake-utils_use_enable chathistory AZOTH_CHATHISTORY)
		$(cmake-utils_use_enable depester AZOTH_DEPESTER)
		$(cmake-utils_use_enable embedmedia AZOTH_EMBEDMEDIA)
		$(cmake-utils_use_enable herbicide AZOTH_HERBICIDE)
		$(cmake-utils_use_enable hili AZOTH_HILI)
		$(cmake-utils_use_enable isterique AZOTH_ISTERIQUE)
		$(cmake-utils_use_enable juick AZOTH_JUICK)
		$(cmake-utils_use_enable keeso AZOTH_KEESO)
		$(cmake-utils_use_enable lastseen AZOTH_LASTSEEN)
		$(cmake-utils_use_enable metacontacts AZOTH_METACONTACTS)
		$(cmake-utils_use_enable media MEDIACALLS)
		$(cmake-utils_use_enable latex AZOTH_MODNOK)
		$(cmake-utils_use_enable msn AZOTH_ZHEET)
		$(cmake-utils_use_enable murm AZOTH_MURM)
		$(cmake-utils_use_enable nativeemoticons AZOTH_NATIVEEMOTICONS)
		$(cmake-utils_use_enable otroid AZOTH_OTROID)
		$(cmake-utils_use_enable p100q AZOTH_P100Q)
		$(cmake-utils_use_enable spell AZOTH_ROSENTHAL)
		$(cmake-utils_use_enable shx AZOTH_SHX)
		$(cmake-utils_use_enable standardstyles AZOTH_STANDARDSTYLES)
		$(cmake-utils_use_enable vader AZOTH_VADER)
		$(cmake-utils_use_enable xmpp AZOTH_XOOX)
		$(cmake-utils_use_enable xtazy AZOTH_XTAZY)
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	use doc && dohtml -r "${CMAKE_BUILD_DIR}"/out/html/*
}

pkg_postinst() {
	if use spell; then
		elog "You have enabled the Azoth Rosenthal plugin for"
		elog "spellchecking. It uses Hunspell/Myspell dictionaries,"
		elog "so install the ones for languages you use to enable"
		elog "spellchecking."
	fi
}
