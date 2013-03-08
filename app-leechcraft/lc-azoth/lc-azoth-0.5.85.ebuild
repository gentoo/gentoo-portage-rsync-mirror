# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-azoth/lc-azoth-0.5.85.ebuild,v 1.1 2013/03/08 21:55:25 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Azoth, the modular IM client for LeechCraft."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug astrality +acetamide +adiumstyles +autoidler +autopaste +birthdaynotifier
		+chathistory +crypt	+depester +embedmedia +herbicide +hili +isterique
		+juick +keeso +lastseen	+metacontacts media +modnok +nativeemoticons
		+otroid +p100q +rosenthal +standardstyles +xoox +xtazy +zheet"

DEPEND="~app-leechcraft/lc-core-${PV}
		dev-qt/qtwebkit:4
		dev-qt/qtmultimedia:4
		autoidler? ( x11-libs/libXScrnSaver )
		astrality? ( net-libs/telepathy-qt )
		otroid? ( =net-libs/libotr-3* )
		media? ( dev-qt/qtmultimedia:4 )
		rosenthal? ( app-text/hunspell )
		xoox? ( =net-libs/qxmpp-0.7* media-libs/speex )
		xtazy? ( dev-qt/qtdbus:4 )
		crypt? ( app-crypt/qca app-crypt/qca-gnupg )
		zheet? ( net-libs/libmsn )"
RDEPEND="${DEPEND}
	astrality? (
		net-im/telepathy-mission-control
		net-voip/telepathy-haze
	)
	modnok? (
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
		$(cmake-utils_use_enable metacontacts AZOTH_LASTSEEN)
		$(cmake-utils_use_enable media MEDIACALLS)
		$(cmake-utils_use_enable modnok AZOTH_MODNOK)
		$(cmake-utils_use_enable nativeemoticons AZOTH_NATIVEEMOTICONS)
		$(cmake-utils_use_enable otroid AZOTH_OTROID)
		$(cmake-utils_use_enable p100q AZOTH_P100Q)
		$(cmake-utils_use_enable rosenthal AZOTH_ROSENTHAL)
		$(cmake-utils_use_enable standardstyles AZOTH_STANDARDSTYLES)
		$(cmake-utils_use_enable xoox AZOTH_XOOX)
		$(cmake-utils_use_enable xtazy AZOTH_XTAZY)
		$(cmake-utils_use_enable zheet AZOTH_ZHEET)
	)

	cmake-utils_src_configure
}

pkg_postinst() {
	if use rosenthal; then
		elog "You have enabled the Azoth Rosenthal plugin for"
		elog "spellchecking. It uses Hunspell/Myspell dictionaries,"
		elog "so install the ones for languages you use to enable"
		elog "spellchecking."
	fi
}
