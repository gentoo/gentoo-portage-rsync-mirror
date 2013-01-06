# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/ricty/ricty-3.1.1.ebuild,v 1.2 2011/11/08 09:57:35 naota Exp $

EAPI=3
inherit font

MY_PN="Ricty"
DESCRIPTION="A beautiful sans-serif monotype Japanese font designed for code listings"
HOMEPAGE="http://save.sys.t.u-tokyo.ac.jp/~yusa/fonts/ricty.html"
SRC_URI="http://save.sys.t.u-tokyo.ac.jp/~yusa/fonts/ricty/${MY_PN}-${PV}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND="media-fonts/inconsolata
	media-fonts/mix-mplus-ipa
	media-gfx/fontforge"
RDEPEND=""

S="${WORKDIR}/${MY_PN}"

FONT_SUFFIX="ttf"
FONT_S="${S}"

# Only installs fonts.
RESTRICT="strip binchecks"

src_compile() {
	sh ricty_generator.sh \
		"${EPREFIX}/usr/share/fonts/inconsolata/Inconsolata.otf" \
		"${EPREFIX}/usr/share/fonts/mix-mplus-ipa/Migu-1M-regular.ttf" \
		"${EPREFIX}/usr/share/fonts/mix-mplus-ipa/Migu-1M-bold.ttf" || die
}
