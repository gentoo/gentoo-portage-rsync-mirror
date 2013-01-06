# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/aquafont/aquafont-2.7-r3.ebuild,v 1.1 2008/09/04 17:08:33 matsuu Exp $

inherit font

MY_P="${PN/font/}${PV/\./_}"

DESCRIPTION="Handwritten Japanese fixed-width TrueType font"
HOMEPAGE="http://www.geocities.jp/teardrops_in_aquablue/"
SRC_URI="http://www.geocities.jp/teardrops_in_aquablue/fnt/${MY_P}.zip"

LICENSE="aquafont"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="X"

S="${WORKDIR}/${MY_P}"
FONT_S="${S}"
FONT_SUFFIX="ttf"

DEPEND="app-arch/unzip"
RDEPEND=""

DOCS="readme.txt"

# Only installs fonts
RESTRICT="strip binchecks"
