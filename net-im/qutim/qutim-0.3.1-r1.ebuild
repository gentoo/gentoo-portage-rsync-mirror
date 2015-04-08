# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/qutim/qutim-0.3.1-r1.ebuild,v 1.4 2015/02/22 18:41:22 mgorny Exp $

EAPI=5

LANGS="ar be bg cs de en_GB ru sk uk zh_CN"

inherit qt4-r2 cmake-utils

DESCRIPTION="Qt4-based multi-protocol instant messenger"
HOMEPAGE="http://www.qutim.org"
SRC_URI="http://www.qutim.org/downloads/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aspell awn ayatana crypt dbus debug doc histman hunspell irc jabber kde kinetic mrim
	multimedia oscar otr phonon purple qml sdl +ssl vkontakte webkit +xscreensaver"

REQUIRED_USE="
	oscar? ( ssl )
"

# Minimum Qt version required
QT_PV="4.7.0:4"

CDEPEND="
	x11-libs/libqxt
	>=dev-qt/qtcore-${QT_PV}[ssl?]
	>=dev-qt/qtgui-${QT_PV}
	>=dev-qt/qtscript-${QT_PV}
	aspell? ( app-text/aspell )
	awn? ( >=dev-qt/qtdbus-${QT_PV} )
	ayatana? ( >=dev-libs/libindicate-qt-0.2.2 )
	crypt? ( app-crypt/qca:2[qt4(+)] )
	dbus? ( >=dev-qt/qtdbus-${QT_PV} )
	debug? ( >=dev-qt/qtdeclarative-${QT_PV} )
	histman? ( >=dev-qt/qtsql-${QT_PV} )
	hunspell? ( app-text/hunspell )
	jabber? (
		app-crypt/qca:2[qt4(+)]
		>=net-libs/jreen-1.1.0
	)
	kde? ( kde-base/kdelibs:4 )
	kinetic? ( >=dev-qt/qtdeclarative-${QT_PV} )
	multimedia? ( >=dev-qt/qtmultimedia-${QT_PV} )
	oscar? ( app-crypt/qca:2[qt4(+)] )
	otr? (
		>=net-libs/libotr-3.2.0
		<net-libs/libotr-4.0.0
	)
	phonon? (
		kde? ( media-libs/phonon[qt4] )
		!kde? ( || ( >=dev-qt/qtphonon-${QT_PV} media-libs/phonon[qt4] ) )
	)
	purple? ( net-im/pidgin )
	qml? (
		>=dev-qt/qtdeclarative-${QT_PV}
		>=dev-qt/qtopengl-${QT_PV}
	)
	sdl? ( media-libs/sdl-mixer )
	vkontakte? ( >=dev-qt/qtwebkit-${QT_PV} )
	webkit? ( >=dev-qt/qtwebkit-${QT_PV} )
	xscreensaver? ( x11-libs/libXScrnSaver )
"
DEPEND="${CDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
	kde? ( dev-util/automoc )
"
RDEPEND="${CDEPEND}
	jabber? ( app-crypt/qca:2[gpg] )
	oscar? ( app-crypt/qca:2[openssl] )
"

DOCS=( AUTHORS ChangeLog )

# bug #506614
PATCHES=(
	"${FILESDIR}/${P}-cmake-2.8.12-qt-build.patch"
	"${FILESDIR}/${P}-cmake-2.8.12-kde-build.patch"
)

src_prepare() {
	cmake-utils_src_prepare

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
		$(cmake-utils_use vkontakte)
	)
	cmake-utils_src_configure
}
