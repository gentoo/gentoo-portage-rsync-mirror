# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/eiskaltdcpp/eiskaltdcpp-9999.ebuild,v 1.32 2013/03/02 23:09:03 hwoarang Exp $

EAPI="4"

LANGS="be bg cs de el en es fr hu it pl ru sk sr@latin uk"

[[ ${PV} = *9999* ]] && VCS_ECLASS="git-2" || VCS_ECLASS=""
inherit cmake-utils ${VCS_ECLASS}

DESCRIPTION="Qt4 based client for DirectConnect and ADC protocols, based on DC++ library"
HOMEPAGE="http://eiskaltdc.googlecode.com/"

LICENSE="GPL-2 GPL-3"
SLOT="0"
IUSE="cli daemon dbus +dht +emoticons examples -gnome -gtk -gtk3 idn -javascript json libcanberra libnotify lua +minimal pcre +qt4 sound spell sqlite upnp xmlrpc"
for x in ${LANGS}; do
	IUSE="${IUSE} linguas_${x}"
done

REQUIRED_USE="
	cli? ( ^^ ( json xmlrpc ) )
	emoticons? ( || ( gtk qt4 ) )
	dbus? ( qt4 )
	gnome? ( gtk )
	gtk3? ( gtk )
	javascript? ( qt4 )
	json? ( !xmlrpc )
	libcanberra? ( !gnome gtk )
	libnotify? ( gtk )
	spell? ( qt4 )
	sound? ( || ( gtk qt4 ) )
	sqlite? ( qt4 )
"

if [[ ${PV} != *9999* ]]; then
	SRC_URI="http://${PN/pp/}.googlecode.com/files/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
else
	EGIT_REPO_URI="git://github.com/${PN}/${PN}.git"
	KEYWORDS=""
fi

RDEPEND="
	app-arch/bzip2
	>=dev-libs/openssl-0.9.8
	sys-apps/attr
	sys-devel/gettext
	sys-libs/zlib
	virtual/libiconv
	idn? ( net-dns/libidn )
	lua? ( >=dev-lang/lua-5.1 )
	pcre? ( >=dev-libs/libpcre-4.2 )
	upnp? ( >=net-libs/miniupnpc-1.6 )
	cli? (
		>=dev-lang/perl-5.10
		perl-core/Getopt-Long
		dev-perl/Data-Dump
		dev-perl/Term-ShellUI
		json? ( dev-perl/JSON-RPC dev-perl/Data-Dump )
		xmlrpc? (  dev-perl/RPC-XML )
	)
	daemon? ( xmlrpc? ( >=dev-libs/xmlrpc-c-1.19.0[abyss,cxx] ) )
	gtk? (
		x11-libs/pango
		gtk3? ( x11-libs/gtk+:3 )
		!gtk3? ( >=x11-libs/gtk+-2.24:2 )
		>=dev-libs/glib-2.24:2
		x11-themes/hicolor-icon-theme
		gnome? ( gnome-base/libgnome )
		libcanberra? ( media-libs/libcanberra )
		libnotify? ( >=x11-libs/libnotify-0.4.1 )
	)
	qt4? (
		>=dev-qt/qtgui-4.6.0:4[dbus?]
		javascript? (
			dev-qt/qtscript:4
			x11-libs/qtscriptgenerator
		)
		spell? ( app-text/aspell )
		sqlite? ( dev-qt/qtsql:4[sqlite] )
	)
"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.34.1
	virtual/pkgconfig
"
DOCS="AUTHORS ChangeLog.txt"

pkg_pretend() {
	if [[ ${MERGE_TYPE} != binary ]]; then
		[[ $(gcc-major-version) -lt 4 ]] || \
				( [[ $(gcc-major-version) -eq 4 && $(gcc-minor-version) -le 4 ]] ) \
			&& die "Sorry, but gcc-4.4 and earlier won't work."
	fi
}

src_configure() {
	# linguas
	local langs x
	for x in ${LANGS}; do
		use linguas_${x} && langs+=" ${x}"
	done

	local mycmakeargs=(
		-DLIB_INSTALL_DIR="$(get_libdir)"
		-Dlinguas="${langs}"
		-DLOCAL_MINIUPNP=OFF
		"$(use cli && cmake-utils_use json USE_CLI_JSONRPC)"
		"$(use cli && cmake-utils_use xmlrpc USE_CLI_XMLRPC)"
		"$(cmake-utils_use daemon NO_UI_DAEMON)"
		"$(use daemon && cmake-utils_use json JSONRPC_DAEMON)"
		"$(use daemon && cmake-utils_use xmlrpc XMLRPC_DAEMON)"
		"$(cmake-utils_use dbus DBUS_NOTIFY)"
		"$(cmake-utils_use dht WITH_DHT)"
		"$(cmake-utils_use emoticons WITH_EMOTICONS)"
		"$(cmake-utils_use examples WITH_EXAMPLES)"
		"$(cmake-utils_use gnome USE_LIBGNOME2)"
		"$(cmake-utils_use gtk USE_GTK)"
		"$(cmake-utils_use gtk3 USE_GTK3)"
		"$(cmake-utils_use idn USE_IDNA)"
		"$(cmake-utils_use javascript USE_JS)"
		"$(cmake-utils_use libcanberra LIBCANBERRA)"
		"$(cmake-utils_use libnotify USE_LIBNOTIFY)"
		"$(cmake-utils_use lua LUA_SCRIPT)"
		"$(cmake-utils_use lua WITH_LUASCRIPTS)"
		"$(cmake-utils_use !minimal WITH_DEV_FILES)"
		"$(cmake-utils_use pcre PERL_REGEX)"
		"$(cmake-utils_use qt4 USE_QT)"
		"$(cmake-utils_use sound WITH_SOUNDS)"
		"$(cmake-utils_use spell USE_ASPELL)"
		"$(cmake-utils_use sqlite USE_QT_SQLITE)"
		"$(cmake-utils_use upnp USE_MINIUPNP)"
	)
	cmake-utils_src_configure
}
