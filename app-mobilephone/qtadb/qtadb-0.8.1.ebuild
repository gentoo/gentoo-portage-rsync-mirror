# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/qtadb/qtadb-0.8.1.ebuild,v 1.3 2011/11/15 23:13:48 hwoarang Exp $

EAPI="4"

inherit eutils qt4-r2

MY_PN="QtADB"
MY_P="${MY_PN}_${PV}_src"

DESCRIPTION="Android phone manager via ADB"
HOMEPAGE="http://qtadb.wordpress.com"
SRC_URI="http://${PN}.com/${PN}/${MY_P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/qt-gui:4
	x11-libs/qt-declarative:4"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/trunk"

src_install() {
	newicon images/android.png ${PN}.png
	make_desktop_entry ${MY_PN} "${MY_PN}" ${PN} \
		"Qt;PDA;Utility;" || die "Desktop entry creation failed"
	dobin ${MY_PN}
}

pkg_postinst() {
	echo
	elog "You will need a working Android SDK installation (adb and aapt executables)"
	elog "You can install Android SDK a) through portage (emerge android-sdk-update-manager"
	elog "and run android to download the actual sdk), b) manually from"
	elog "http://developer.android.com/sdk/index.html or c) just grab the adb, aapt linux"
	elog "binaries from http://qtadb.wordpress.com/download/"
	elog "adb and aapt executables are in the platform-tools subdir of Android SDK"
	echo
	elog "Also you will need to have ROOT access to your phone along with busybox"
	elog "The latter can be found in the Android market"
	echo
	elog "Last, if you want to use the SMS manager of QtADB, you have to install"
	elog "QtADB.apk to your device, available here: http://qtadb.wordpress.com/download/"
	echo
	elog "If you have trouble getting your phone connected through usb (driver problem),"
	elog "try adbWireless from Android market to get connected through WiFi"
	echo
}
