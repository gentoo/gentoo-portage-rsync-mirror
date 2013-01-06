# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/umeplus-fonts/umeplus-fonts-20090918a.ebuild,v 1.1 2009/10/02 22:45:26 matsuu Exp $

inherit font

DESCRIPTION="UmePlus fonts are modified Ume and M+ fonts for Japanese"
HOMEPAGE="http://www.geocities.jp/ep3797/modified_fonts_01.html"
SRC_URI="http://www.geocities.jp/ep3797/snapshot/modified_fonts/${P}.tar.bz2"

LICENSE="as-is mplus-fonts"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Only installs fonts
RESTRICT="strip binchecks"

FONT_S="${S}"

FONT_SUFFIX="ttf"
DOCS="ChangeLog README"
