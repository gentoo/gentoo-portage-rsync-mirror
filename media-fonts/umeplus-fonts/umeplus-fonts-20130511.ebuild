# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/umeplus-fonts/umeplus-fonts-20130511.ebuild,v 1.2 2014/01/12 09:45:40 pacho Exp $

EAPI="5"

inherit font

DESCRIPTION="UmePlus fonts are modified Ume and M+ fonts for Japanese"
HOMEPAGE="http://www.geocities.jp/ep3797/modified_fonts_01.html"
SRC_URI="mirror://sourceforge/mdk-ut/${P}.tar.lzma"

LICENSE="mplus-fonts public-domain"
SLOT="0"
KEYWORDS="amd64 ~x86 ~ppc-macos ~x86-macos"
IUSE=""

# Only installs fonts
RESTRICT="binchecks strip"

FONT_S="${S}"

FONT_SUFFIX="ttf"
DOCS="ChangeLog README"
