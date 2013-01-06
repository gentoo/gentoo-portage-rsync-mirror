# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/qutim/qutim-0.3.1.ebuild,v 1.5 2012/10/19 16:10:42 kensington Exp $

EAPI=4

LANGS="ar be bg cs de en_GB ru sk uk zh_CN"

inherit qt4-r2 cmake-utils

DESCRIPTION="Qt4-based multi-protocol instant messenger"
HOMEPAGE="http://www.qutim.org"
SRC_URI="http://www.qutim.org/downloads/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aspell awn ayatana crypt dbus debug doc histman hunspell irc jabber kde kinetic mrim
	multimedia oscar otr phonon purple qml sdl +ssl telepathy vkontakte webkit +xscreensaver"

REQUIRED_USE="
	oscar? ( ssl )
"

# Minimum Qt version required
QT_PV="4.7.0:4"

CDEPEND="
	x11-libs/libqxt
	>=x11-libs/qt-core-${QT_PV}[ssl?]
	>=x11-libs/qt-gui-${QT_PV}
	>=x11-libs/qt-script-${QT_PV}
	aspell? ( app-text/aspell )
	awn? ( >=x11-libs/qt-dbus-${QT_PV} )
	ayatana? ( >=dev-libs/libindicate-qt-0.2.2 )
	crypt? ( app-crypt/qca:2 )
	dbus? ( >=x11-libs/qt-dbus-${QT_PV} )
	debug? ( >=x11-libs/qt-declarative-${QT_PV} )
	histman? ( >=x11-libs/qt-sql-${QT_PV} )
	hunspell? ( app-text/hunspell )
	jabber? (
		app-crypt/qca:2
		>=net-libs/jreen-1.1.0
	)
	kde? ( kde-base/kdelibs:4 )
	kinetic? ( >=x11-libs/qt-declarative-${QT_PV} )
	multimedia? ( >=x11-libs/qt-multimedia-${QT_PV} )
	oscar? ( app-crypt/qca:2 )
	otr? (
		>=net-libs/libotr-3.2.0
		<net-libs/libotr-4.0.0
	)
	phonon? (
		kde? ( media-libs/phonon )
		!kde? ( || ( >=x11-libs/qt-phonon-${QT_PV} media-libs/phonon ) )
	)
	purple? ( net-im/pidgin )
	qml? (
		>=x11-libs/qt-declarative-${QT_PV}
		>=x11-libs/qt-opengl-${QT_PV}
	)
	sdl? ( media-libs/sdl-mixer )
	telepathy? ( =net-libs/telepathy-qt-0.8* )
	vkontakte? ( >=x11-libs/qt-webkit-${QT_PV} )
	webkit? ( >=x11-libs/qt-webkit-${QT_PV} )
	xscreensaver? ( x11-libs/libXScrnSaver )
"
DEPEND="${CDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
	kde? ( dev-util/automoc )
"
RDEPEND="${CDEPEND}
	jabber? ( app-crypt/qca-gnupg:2 )
	oscar? ( app-crypt/qca-ossl:2 )
"

DOCS=( AUTHORS ChangeLog )

src_prepare() {
	base_src_prepare

	# fix automagic dep on libXScrnSaver
	if ! use xscreensaver; then
		sed -i -e '/XSS xscrnsaver/d' \
			core/src/corelayers/idledetector/CMakeLists.txt || die
	fi

	# remove unwanted translations
	local lang
	for lang in ${LANGS}; do
		use linguas_${lang} || rm -f translations/modules/*/${lang}.{po,ts}
	done
}

src_configure() {
	local mycmakeargs=(
		-DSYSTEM_JREEN=ON
		$(cmake-utils_use_with doc DOXYGEN)
		$(cmake-utils_use doc QUTIM_GENERATE_DOCS)
		# plugins
		$(cmake-utils_use aspell ASPELLER)
		$(cmake-utils_use awn)
		$(cmake-utils_use ayatana INDICATOR)
		$(cmake-utils_use crypt AESCRYPTO)
		$(cmake-utils_use dbus DBUSAPI)
		$(cmake-utils_use dbus DBUSNOTIFICATIONS)
		$(cmake-utils_use dbus NOWPLAYING)
		$(cmake-utils_use debug LOGGER)
		$(cmake-utils_use histman)
		$(cmake-utils_use hunspell HUNSPELLER)
		$(cmake-utils_use kde KDEINTEGRATION)
		$(cmake-utils_use kinetic KINETICPOPUPS)
		$(cmake-utils_use multimedia MULTIMEDIABACKEND)
		$(cmake-utils_use otr OFFTHERECORD)
		$(cmake-utils_use phonon PHONONSOUND)
		$(cmake-utils_use qml QMLCHAT)
		$(cmake-utils_use sdl SDLSOUND)
		$(cmake-utils_use webkit ADIUMWEBVIEW)
		-DHAIKUNOTIFICATIONS=OFF
		-DUNITYLAUNCHER=OFF
		-DUPDATER=OFF
		# protocols
		$(cmake-utils_use irc)
		$(cmake-utils_use jabber)
		$(cmake-utils_use mrim)
		$(cmake-utils_use oscar)
		$(cmake-utils_use purple QUETZAL)
		$(cmake-utils_use telepathy ASTRAL)
		$(cmake-utils_use vkontakte)
	)
	cmake-utils_src_configure
}
