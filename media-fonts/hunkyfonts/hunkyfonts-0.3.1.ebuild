# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/hunkyfonts/hunkyfonts-0.3.1.ebuild,v 1.9 2008/02/24 12:18:22 armin76 Exp $

inherit font

IUSE=""

DESCRIPTION="Hunky Fonts are free TrueType fonts based on Bitstream's Vera fonts with additional letters."
HOMEPAGE="http://sourceforge.net/projects/hunkyfonts/"
SRC_URI="mirror://sourceforge/hunkyfonts/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc s390 sh sparc x86 ~x86-fbsd"

FONT_S="${WORKDIR}/${P}/TTF"
FONT_SUFFIX="ttf"

DOCS="ChangeLog README"
