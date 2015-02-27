# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/libertine/libertine-5.3.0.20120702-r1.ebuild,v 1.1 2015/02/27 09:34:09 yngwin Exp $

EAPI=5
inherit font versionator

MY_DATE=$(get_version_component_range 4)
MY_PV=$(get_version_component_range 1-3)_${MY_DATE:0:4}_${MY_DATE:4:2}_${MY_DATE:6}
MY_P_OTF="LinLibertineOTF_${MY_PV}"
MY_P_TTF="LinLibertineTTF_${MY_PV}"

DESCRIPTION="Fonts from the Linux Libertine Open Fonts Project"
HOMEPAGE="http://linuxlibertine.org/"
SRC_URI="mirror://sourceforge/linuxlibertine/${MY_P_OTF}.tgz
	mirror://sourceforge/linuxlibertine/${MY_P_TTF}.tgz"

LICENSE="|| ( GPL-2-with-font-exception OFL-1.1 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="+opentype"

RDEPEND="!<x11-libs/pango-1.20.4"

S="${WORKDIR}"
FONT_S="${S}"
DOCS="Bugs.txt ChangeLog.txt README Readme-TEX.txt"

if use opentype; then
	FONT_SUFFIX="otf"
else
	FONT_SUFFIX="ttf"
fi
