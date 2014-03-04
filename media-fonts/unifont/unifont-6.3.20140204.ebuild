# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/unifont/unifont-6.3.20140204.ebuild,v 1.4 2014/03/04 21:48:54 floppym Exp $

EAPI=5

inherit eutils font toolchain-funcs

DESCRIPTION="GNU Unifont - a Pan-Unicode X11 bitmap iso10646 font"
HOMEPAGE="http://unifoundry.com/"
SRC_URI="mirror://gnu/${PN}/${P}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia64 ~x86"
IUSE="fontforge utils"

DEPEND="
	fontforge? (
		app-text/bdf2psf
		dev-lang/perl
		media-gfx/fontforge
		x11-apps/bdftopcf
	)
"
RDEPEND="
	utils? ( dev-lang/perl )
"

src_prepare() {
	sed -i -e 's/install -s/install/' src/Makefile || die
	epatch "${FILESDIR}/unifont-6.3.20140204-make.patch"
	epatch_user
}

src_compile() {
	tc-export CC
	makeargs=(
		CFLAGS="${CFLAGS}"
	)
	use fontforge && emake -j1 "${makeargs[@]}" BUILDFONT=1
}

src_install() {
	makeargs+=(
		DESTDIR="${ED%/}"
		PCFDEST="${ED%/}${FONTDIR}"
		TTFDEST="${ED%/}${FONTDIR}"
		USRDIR=usr
	)
	use utils || makeargs+=( -C font )
	emake -j1 "${makeargs[@]}" install
	font_xfont_config
	font_fontconfig
}
