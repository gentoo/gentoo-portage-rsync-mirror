# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/freefont-ttf/freefont-ttf-20120503.ebuild,v 1.1 2013/01/26 16:09:57 nirbheek Exp $

EAPI="5"

inherit font

DESCRIPTION="OpenType and TrueType Unicode fonts from the Free UCS Outline Fonts Project"
HOMEPAGE="http://savannah.nongnu.org/projects/freefont/"
SRC_URI="mirror://gnu/freefont/${P}.zip
	mirror://gnu/freefont/${P/-ttf/-otf}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="app-arch/unzip"

FONT_SUFFIX="otf ttf"
S=${WORKDIR}/freefont-${PV}
FONT_S=${S}
DOCS="AUTHORS ChangeLog CREDITS TROUBLESHOOTING USAGE"

RESTRICT="strip binchecks"
