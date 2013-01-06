# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/anonymous-pro/anonymous-pro-1.001.ebuild,v 1.2 2010/02/02 09:02:56 scarabeus Exp $

EAPI="2"
inherit font

MY_PN="AnonymousPro"
DESCRIPTION="Monospaced truetype font designed with coding in mind"
HOMEPAGE="http://www.ms-studio.com/FontSales/anonymouspro.html"
SRC_URI="http://www.ms-studio.com/FontSales/${MY_PN}.zip -> ${P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

FONT_SUFFIX="ttf"
FONT_S="${WORKDIR}/${MY_PN}"
DOCS="FONTLOG.txt README.txt"

S=${FONT_S}

# Only installs fonts.
RESTRICT="strip binchecks"
