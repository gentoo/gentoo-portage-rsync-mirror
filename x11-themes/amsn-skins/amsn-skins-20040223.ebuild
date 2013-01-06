# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/amsn-skins/amsn-skins-20040223.ebuild,v 1.15 2011/10/23 16:00:02 armin76 Exp $

S=${WORKDIR}
DESCRIPTION="Collection of AMSN themes"
HOMEPAGE="http://amsn.sourceforge.net/"
THEME_URI="mirror://sourceforge/amsn/"
SRC_URI="${THEME_URI}/aMac.zip
	${THEME_URI}/Bolos.zip
	${THEME_URI}/crystola.zip
	${THEME_URI}/cubic.zip
	${THEME_URI}/Fluox.zip
	${THEME_URI}/MSN.zip"
RESTRICT="mirror"
SLOT="0"
LICENSE="freedist"
KEYWORDS="amd64 ppc ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="net-im/amsn"

src_install () {
	dodir /usr/share/amsn/skins
	cp -r "${S}"/* "${D}"/usr/share/amsn/skins/
}
