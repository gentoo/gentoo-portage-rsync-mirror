# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/freefont-ttf/freefont-ttf-20090104.ebuild,v 1.4 2009/05/28 19:43:05 beandog Exp $

inherit font

DESCRIPTION="TrueType Unicode fonts from the Free UCS Outline Fonts Project"
HOMEPAGE="http://savannah.nongnu.org/projects/freefont/"
SRC_URI="mirror://gnu/freefont/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc ~ppc64 sparc x86"

IUSE=""

FONT_SUFFIX="ttf"
S=${WORKDIR}/freefont-${PV}
FONT_S=${S}
DOCS="CREDITS"

RESTRICT="strip binchecks"
