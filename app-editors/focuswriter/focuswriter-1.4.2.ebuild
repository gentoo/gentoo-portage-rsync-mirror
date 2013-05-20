# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/focuswriter/focuswriter-1.4.2.ebuild,v 1.3 2013/05/20 08:37:14 ago Exp $

EAPI=5
PLOCALES="ca cs da de el en es es_MX fi fr he hu it ja nl pl pt pt_BR ro ru
sk sv tr uk zh_CN"
PLOCALE_BACKUP="en"
inherit qt4-r2 l10n readme.gentoo

DESCRIPTION="A fullscreen and distraction-free word processor"
HOMEPAGE="http://gottcode.org/focuswriter/"
SRC_URI="http://gottcode.org/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug"

RDEPEND="app-text/enchant
	dev-libs/libzip
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	sys-libs/zlib"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( ChangeLog CREDITS README )
DOC_CONTENTS="Focuswriter has optional sound support if media-libs/sdl-mixer is
installed with wav useflag enabled."

src_prepare() {
	l10n_for_each_disabled_locale_do rm_loc
}

src_configure() {
	eqmake4 PREFIX="${EPREFIX}/usr"
}

src_install() {
	readme.gentoo_create_doc
	qt4-r2_src_install
}

rm_loc() {
	sed -e "s|translations/${PN}_${1}.ts||"	-i ${PN}.pro || die 'sed failed'
	rm translations/${PN}_${1}.{ts,qm} || die "removing ${1} locale failed"
}
