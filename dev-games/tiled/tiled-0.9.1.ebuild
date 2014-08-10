# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/tiled/tiled-0.9.1.ebuild,v 1.2 2014/08/10 20:06:39 slyfox Exp $

EAPI=5

PLOCALES="cs de en es fr he it ja lv nl pt pt_BR ru zh"
MY_P="${PN}-qt-${PV}"

inherit multilib l10n qt4-r2

DESCRIPTION="A general purpose tile map editor"
HOMEPAGE="http://www.mapeditor.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

DEPEND=">=dev-qt/qtcore-4.6:4
	>=dev-qt/qtgui-4.6:4
	>=dev-qt/qtopengl-4.6:4
	sys-libs/zlib"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

DOCS=( AUTHORS COPYING NEWS README.md )

src_prepare() {
	rm -r src/zlib || die
	sed -e "s/^LANGUAGES =.*/LANGUAGES = $(l10n_get_locales)/" \
		-i translations/translations.pro || die
}

src_configure() {
	eqmake4 LIBDIR="/usr/$(get_libdir)" PREFIX="/usr"
}

src_install() {
	qt4-r2_src_install

	if use examples ; then
		docompress -x /usr/share/doc/${PF}/examples
		dodoc -r examples
	fi
}
