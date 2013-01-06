# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/picasa/picasa-2.7.3736.15.ebuild,v 1.4 2011/03/29 12:24:56 angelos Exp $

EAPI=1
inherit eutils versionator rpm

MY_P="picasa-$(replace_version_separator 3 '-')"
DESCRIPTION="Google's photo organizer"
HOMEPAGE="http://picasa.google.com"
SRC_URI="http://dl.google.com/linux/rpm/stable/i386/${MY_P}.i386.rpm"
LICENSE="google-picasa"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
RESTRICT="mirror strip"
QA_TEXTRELS_x86="opt/picasa/wine/lib/wine/set_lang.exe.so
		opt/picasa/wine/lib/wine/browser_prompt.exe.so
		opt/picasa/wine/lib/wine/license.exe.so"
#QA_EXECSTACK_x86="opt/picasa/bin/xsu
#               opt/picasa/wine/bin/wine
#               opt/picasa/wine/bin/wineserver
#               opt/picasa/wine/bin/wine-pthread
#               opt/picasa/wine/bin/wine-kthread
#               opt/picasa/wine/lib/*
#               opt/picasa/wine/lib/wine/*"

RDEPEND="x86? (
		dev-libs/atk
		dev-libs/glib:2
		dev-libs/libxml2:2
		sys-libs/zlib
		x11-libs/gtk+:2
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXt
		x11-libs/pango )
	amd64? (
		app-emulation/emul-linux-x86-gtklibs )"

S="${WORKDIR}"

src_unpack() {
	rpm_src_unpack ${A}
}

src_install() {
	cd opt/picasa
	dodir /opt/picasa
	mv bin wine "${D}/opt/picasa/"

	dodir /usr/bin
	for i in picasa picasafontcfg mediadetector showpicasascreensaver; do
		dosym /opt/picasa/bin/${i} /usr/bin/${i}
	done

	dodoc README LICENSE.FOSS

	cd desktop

	mv google-picasa-mediadetector.desktop.template google-picasa-mediadetector.desktop
	mv google-picasa.desktop.template google-picasa.desktop
	mv google-picasa-fontcfg.desktop.template google-picasa-fontcfg.desktop

	sed -i -e "s:EXEC:mediadetector:" google-picasa-mediadetector.desktop
	sed -i -e "s:EXEC:picasa:" google-picasa.desktop
	sed -i -e "s:ICON:picasa.xpm:" google-picasa{,-mediadetector}.desktop
	sed -i -e "s:EXEC:picasafontcfg:" google-picasa-fontcfg.desktop
	sed -i -e "s:ICON:picasa-fontcfg.xpm:" google-picasa-fontcfg.desktop

	echo "Categories=Graphics;" >> google-picasa.desktop
	echo "Categories=Graphics;" >> google-picasa-fontcfg.desktop

	doicon picasa.xpm picasa-fontcfg.xpm
	domenu {google-picasa{,-mediadetector,-fontcfg},picasascr}.desktop
}
