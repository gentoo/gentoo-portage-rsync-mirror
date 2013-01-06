# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/cdplayer/cdplayer-0.5-r1.ebuild,v 1.1 2011/04/20 15:35:43 voyageur Exp $

EAPI=4
inherit gnustep-2

S=${WORKDIR}/CDPlayer-${PV}

DESCRIPTION="Small CD Audio Player for GNUstep"
HOMEPAGE="http://gsburn.sf.net"
SRC_URI="mirror://sourceforge/gsburn/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
SLOT="0"

IUSE="preferences +systempreferences"
DEPEND=">=media-libs/libcdaudio-0.7
	preferences? ( gnustep-apps/preferences )
	systempreferences? ( gnustep-apps/systempreferences )
	gnustep-libs/cddb"
RDEPEND="${DEPEND}"

cdplayer_preferences() {
	# SystemPreferences over Preferences
	if use systempreferences; then
		echo "prefs=sysprefs"
	elif use preferences; then
		echo ""
	else
		echo "prefs=no"
	fi
}

src_prepare() {
	# Reserved keyword
	sed -e "s/bool/boolean/" -i Cddb/Cddb.h || die "sed failed"
}

src_compile() {
	egnustep_env
	egnustep_make $(cdplayer_preferences) || die "make failed"
}

src_install() {
	egnustep_env
	egnustep_install $(cdplayer_preferences) || die "install failed"
	egnustep_install_config
}

gnustep_config_script() {
	echo "echo ' * Setting AudioCD device to /dev/cdrom'"
	echo "defaults write AudioCD Devices '(/dev/cdrom)'"
}
