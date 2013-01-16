# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/umeplus-fonts/umeplus-fonts-20120403.ebuild,v 1.2 2013/01/16 20:29:38 ulm Exp $

inherit font

DESCRIPTION="UmePlus fonts are modified Ume and M+ fonts for Japanese"
HOMEPAGE="http://www.geocities.jp/ep3797/modified_fonts_01.html"
SRC_URI="mirror://sourceforge/mdk-ut/${P}.tar.lzma"

LICENSE="mplus-fonts public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x86-macos"
IUSE=""

# Only installs fonts
RESTRICT="strip binchecks"

FONT_S="${S}"

FONT_SUFFIX="ttf"
DOCS="ChangeLog README"
