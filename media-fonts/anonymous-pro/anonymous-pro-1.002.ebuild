# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/anonymous-pro/anonymous-pro-1.002.ebuild,v 1.1 2011/01/18 23:10:46 spatz Exp $

EAPI=3

inherit font

MY_PN="AnonymousPro"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Monospaced truetype font designed with coding in mind"
HOMEPAGE="http://www.ms-studio.com/FontSales/anonymouspro.html"
SRC_URI="http://www.ms-studio.com/FontSales/${MY_P}.zip"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

FONT_SUFFIX="ttf"
FONT_S="${WORKDIR}/${MY_P}.001"
DOCS="FONTLOG.txt README.txt"

S=${FONT_S}

# Only installs fonts.
RESTRICT="strip binchecks"
