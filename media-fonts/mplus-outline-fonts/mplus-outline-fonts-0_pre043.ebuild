# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mplus-outline-fonts/mplus-outline-fonts-0_pre043.ebuild,v 1.2 2011/12/03 13:53:21 grobian Exp $

EAPI="3"
inherit font

MY_P="mplus-${PV/0_pre/TESTFLIGHT-}"
DESCRIPTION="M+ Japanese outline fonts with IPA font"
HOMEPAGE="http://mplus-fonts.sourceforge.jp/ https://sourceforge.jp/projects/opfc/"
SRC_URI="mirror://sourceforge.jp/mplus-fonts/6650/${MY_P}.tar.gz"

LICENSE="mplus-fonts IPAfont"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~x86 ~ppc-macos ~x86-macos"
IUSE="ipafont"

DEPEND="ipafont? (
		media-gfx/fontforge
		>=media-fonts/ja-ipafonts-003.02
	)"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

FONT_SUFFIX="ttf"
FONT_S="${S}"

DOCS="README_J README_E"

RESTRICT="strip binchecks"

IPAFONT_DIR="${EPREFIX}/usr/share/fonts/ja-ipafonts"

src_prepare() {
	if use ipafont ; then
		cp -p "${IPAFONT_DIR}/ipag.ttf" "${S}" || die
	fi
}

src_compile() {
	if use ipafont ; then
		fontforge -script m++ipa.pe || die
		rm -f ipag.ttf || die
	fi
}
