# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/amsn-skins/amsn-skins-20061125.ebuild,v 1.11 2011/10/23 16:00:02 armin76 Exp $

S=${WORKDIR}
DESCRIPTION="Collection of AMSN themes"
HOMEPAGE="http://amsn.sourceforge.net/"
THEME_URI="mirror://sourceforge/amsn"
SRC_URI="${THEME_URI}/aMac.zip
	${THEME_URI}/Bolos.zip
	${THEME_URI}/crystola.zip
	${THEME_URI}/cubic.zip
	${THEME_URI}/Fluox.zip
	${THEME_URI}/MSN.zip
	${THEME_URI}/aDarwinV.4-0.95.zip
	${THEME_URI}/Candy-1.0.zip
	${THEME_URI}/amsn-for-mac-0.95.zip
	${THEME_URI}/aMSN_Live-1.0.tar.gz
	${THEME_URI}/AQUA-0.95.zip
	${THEME_URI}/Aquaish-1.0.zip
	${THEME_URI}/BrushedMetal-0.95.zip
	${THEME_URI}/C12_Dapper_Theme-1.0.zip
	${THEME_URI}/CatalunyaSkin-1.0.zip
	${THEME_URI}/Clearlooks-0.95.zip
	${THEME_URI}/Emerald-1.0.tar.gz
	${THEME_URI}/FCB-skin-1_0.zip
	${THEME_URI}/Franto2-1.0.zip
	${THEME_URI}/haudrey_aMSN_v1.2.zip
	${THEME_URI}/Ixtus-1.0.zip
	${THEME_URI}/Kubuntu-1.6.tar.gz
	${THEME_URI}/nilo-skin_v0.2-0.95.zip
	${THEME_URI}/TheNoNameBrand-0.95.zip
	${THEME_URI}/pmdzskin-1.0.zip
	${THEME_URI}/snowgrey-0.95.zip
	${THEME_URI}/Tiger_Xi_v1.0.zip
	${THEME_URI}/Tux-0.95.zip
	${THEME_URI}/Ubuntu-1.0b.tar.gz
	${THEME_URI}/Unified-0.95.zip
	${THEME_URI}/Windows_Classic-1.0.zip
	${THEME_URI}/WinMSN7-1.0.zip"
RESTRICT="mirror"
SLOT="0"
LICENSE="freedist"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="net-im/amsn"

src_install () {
	dodir /usr/share/amsn/skins
	cp -r "${S}"/* "${D}"/usr/share/amsn/skins/
}
