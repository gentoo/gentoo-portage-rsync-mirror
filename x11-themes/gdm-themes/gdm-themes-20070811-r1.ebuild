# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gdm-themes/gdm-themes-20070811-r1.ebuild,v 1.6 2013/02/07 22:48:03 ulm Exp $

inherit eutils

DESCRIPTION="Some nice themes for the GDM Greeter"
S=${WORKDIR}
THEME_URI="http://art.gnome.org/download/themes/gdm_greeter/"
SRC_URI="${THEME_URI}1327/GDM-Curve.tar.gz
	${THEME_URI}1277/GDM-SoftFlowerWidescreen1280x800.tar.gz
	${THEME_URI}1042/GDM-GDMLamp.tar.gz
	${THEME_URI}1212/GDM-EarthLights.tar.gz
	${THEME_URI}1229/GDM-SoftFlowerGdm.tar.gz
	${THEME_URI}1201/GDM-BlueSwirl.tar.bz2
	${THEME_URI}1039/GDM-ManzanaTux.tar.gz
	${THEME_URI}1209/GDM-Tango.tar.gz
	${THEME_URI}1036/GDM-CleanLinux.tar.gz
	${THEME_URI}1037/GDM-CleanX.tar.gz
	${THEME_URI}1038/GDM-Sakura.tar.gz
	${THEME_URI}1035/GDM-CleanGnome.tar.gz
	${THEME_URI}1207/GDM-SimpleElegance.tar.gz
	${THEME_URI}1226/GDM-Wolf.tar.gz
	${THEME_URI}1046/GDM-DroplineFun.tar.bz2
	${THEME_URI}1210/GDM-SpanishNight.tar.gz
	${THEME_URI}1072/GDM-SunPuttingInAlmeriaSpain.tar.gz
	${THEME_URI}1073/GDM-Northside.tar.gz
	${THEME_URI}1093/GDM-AproachOne.tar.gz
	${THEME_URI}1293/GDM-EaseOfBlue.tar.bz2
	${THEME_URI}1174/GDM-GnomeBlack.tar.gz
	${THEME_URI}1173/GDM-GnomeZen.tar.gz
	${THEME_URI}1052/GDM-GNOMEPlanetByEmailandthingsCom.tar.gz
	${THEME_URI}1152/GDM-Insectz.tar.gz
	${THEME_URI}1034/GDM-FlyAway.tar.gz
	${THEME_URI}1292/GDM-SunergosGDM.tar.gz
	${THEME_URI}1132/GDM-CelticWXGA.tar.gz
	${THEME_URI}1117/GDM-GnomeIsland.tar.gz
	${THEME_URI}1328/GDM-DarkCleanLinux.tar.gz
	${THEME_URI}1266/GDM-GnomeMoment.tar.gz
	${THEME_URI}1159/GDM-PiratesOfGnome.tar.gz
	${THEME_URI}1116/GDM-GNOMECorvette.tar.gz
	${THEME_URI}1326/GDM-LoginScanFusion.tar.gz
	${THEME_URI}1115/GDM-Earth.tar.gz
	${THEME_URI}1208/GDM-BaltixNorthsidewithUserfaceList.tar.gz
	${THEME_URI}1200/GDM-GreenForest.tar.gz
	${THEME_URI}1260/GDM-GinzaGDMTheme.tar.gz
	${THEME_URI}1145/GDM-FernandoAlonso.tar.gz
	${THEME_URI}1211/GDM-ZX6R.tar.bz2
	${THEME_URI}1248/GDM-BackcountrySkiing.tar.gz
	${THEME_URI}1321/GDM-GdmMadTux2.tar.gz
	${THEME_URI}1282/GDM-GdmMadTux.tar.gz
	${THEME_URI}1302/GDM-SimpleBlue.tar.gz
	${THEME_URI}1320/GDM-Greenlines.tar.gz
	${THEME_URI}1139/GDM-VarietyBrushed.tar.gz
	${THEME_URI}1322/GDM-YZF600R.tar.gz
	${THEME_URI}1262/GDM-LoznicaSerbia.tar.gz
	${THEME_URI}1308/GDM-SunergosSimple.tar.gz
	${THEME_URI}1137/GDM-WhiteFootOnGreen.tar.gz

	${THEME_URI}1298/GDM-GNULinuxBuddhistGDMColourENG.tar.gz
	${THEME_URI}1160/GDM-LandingClearance.tar.gz
	${THEME_URI}1351/GDM-SharpGDM.tar.gz
	${THEME_URI}1307/GDM-BalloonsBlueGDM.tar.gz
	${THEME_URI}1310/GDM-ZenLogin.tar.gz
	${THEME_URI}1349/GDM-LightCoffee.tar.gz"

HOMEPAGE="http://art.gnome.org/themes/gdm_greeter/"

RDEPEND="gnome-base/gdm"
DEPEND="app-arch/unzip"

SLOT="0"
LICENSE="CC-BY-NC-ND-2.0 CC-BY-2.0 GPL-2
LGPL-2.1 public-domain"
KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 sparc x86"
IUSE=""

src_unpack() {
	return 0
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	dodir /usr/share/gdm/themes
	cd "${D}"/usr/share/gdm/themes

	unpack ${A}
	epatch "${FILESDIR}"/soft-flower-gdm.diff
	epatch "${FILESDIR}"/gdm-themes-landclear.patch

	chmod -R ugo=rX *
}
