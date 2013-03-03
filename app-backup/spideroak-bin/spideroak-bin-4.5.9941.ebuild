# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/spideroak-bin/spideroak-bin-4.5.9941.ebuild,v 1.3 2013/03/02 19:12:04 hwoarang Exp $

EAPI="4"

inherit eutils versionator

REV=$(get_version_component_range 3)
SRC_URI_BASE="https://spideroak.com/directdownload?platform=ubuntulucid"

DESCRIPTION="An easy, secure and consolidated free online backup, storage, access and sharing system."
HOMEPAGE="https://spideroak.com"
SRC_URI="x86? ( ${SRC_URI_BASE}&arch=i386&revision=${REV} -> ${P}_x86.deb )
	amd64? ( ${SRC_URI_BASE}&arch=x86_64&revision=${REV} -> ${P}_amd64.deb )"
RESTRICT="mirror strip"

LICENSE="spideroak"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus headless system-libs"

SSL_SLOT="0.9.8"

DEPEND=""
RDEPEND="
	dbus? ( sys-apps/dbus )
	!headless? (
		media-libs/fontconfig
		media-libs/freetype:2
		dev-libs/glib:2
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXmu
		x11-libs/libXrender
		x11-libs/libXt
	)
	system-libs? (
		dev-libs/openssl:$SSL_SLOT
		net-misc/curl
		>=sys-devel/gcc-4
		dev-libs/glib:2
		dev-libs/libpcre
		media-libs/libpng:1.2
		dev-qt/qtcore:4
		dev-qt/qtgui:4
		dev-db/sqlite:3
		net-libs/libssh2
		sys-libs/zlib
		dev-lang/python:2.7
		dev-python/pycurl
	)
"

S=${WORKDIR}

QA_PREBUILT="*"

src_unpack() {
	unpack ${A}
	unpack ./data.tar.gz
	rm -f control.tar.gz data.tar.gz debian-binary
	rm -f usr/share/doc/spideroak/copyright
}

src_prepare() {
	epatch "${FILESDIR}"/opt-path.patch
	use headless && epatch "${FILESDIR}"/headless.patch

	# Remove bundled libraries/plugins/python interpreter.  Please keep this
	# mapping in sync with the RDEPEND system-libs? ( atoms ) above, and the
	# list of deleted files below
	#
	#  libcrypto.so.0.$SSL_SLOT  => dev-libs/openssl:$SSL_SLOT
	#  libssl.so.$SSL_SLOT       => dev-libs/openssl:$SSL_SLOT
	#  libcurl.so*     => net-misc/curl
	#  libexpat.so*    => dev-libs/expat
	#  libgcc_s.so     => >=sys-devel/gcc-4
	#  libstdc++.so*   => >=sys-devel/gcc-4
	#  libpcre.so*     => dev-libs/libpcre
	#  libpng12*       => media-libs/libpng:1.2
	#  libQt*.so*      => dev-qt/qtcore dev-qt/qtgui
	#  libsqlite3.so*  => dev-db/sqlite:3
	#  libssh2.so*     => net-libs/libssh2
	#  libz.so*        => sys-libs/zlib
	#
	#  pycurl.so       => dev-python/pycurl
	#
	#  usr/lib/SpiderOak/py pyexpat.so => dev-lang/python:2.7
	#
	if use system-libs; then
		for lib in                 \
			libcrypto.so.$SSL_SLOT \
			libssl.so.$SSL_SLOT    \
			libcurl.so*            \
			libexpat.so*           \
			libgcc_s.so*           \
			libpcre.so*            \
			libpng12*              \
			libQt*.so*             \
			libsqlite3.so*         \
			libssh2.so*            \
			libstdc++.so*          \
			libz.so*               \
			pycurl.so              \
			pyexpat.so
		do
			rm usr/lib/SpiderOak/$lib || die "rm $lib failed"
		done

		# Remove bundled python interpreter => dev-lang/python:2.7
		rm usr/lib/SpiderOak/py || die "rm py failed"
	fi
}

src_install() {
	#install the executable script
	exeinto /usr/bin
	doexe usr/bin/SpiderOak

	#install the prebundled libraries
	dodir /opt
	cp -pPR usr/lib/SpiderOak "${ED}"/opt/

	#install the config files
	rm -rf etc/apt
	use dbus || rm -rf etc/dbus-1
	insinto /
	doins -r etc

	#install the changelog
	insinto /usr/share/doc/${P}
	doins usr/share/doc/spideroak/changelog.gz

	if ! use headless ; then
		domenu usr/share/applications/spideroak.desktop
		doicon usr/share/pixmaps/spideroak.png
	fi
}

pkg_postinst() {
	if use headless; then
		einfo "For instructions on running SpiderOak without a GUI, please read the FAQ:"
		einfo "  https://spideroak.com/faq/questions/62/how_do_i_install_spideroak_on_a_headless_linux_server/"
		einfo "  https://spideroak.com/faq/questions/67/how_can_i_use_spideroak_from_the_commandline/"
	fi
	if use system-libs; then
		einfo "You have chosen to use your system libraries rather than the precompiled libraries that"
		einfo "SpiderOak bundles with their software.  While upstream discourages this (see bug #398313),"
		einfo "there are advantages to using the system libraries, like reducing the size of the package"
		einfo "on your hard drive.  For more reasons why bundled librars are not a good idea, see"
		einfo "  https://fedoraproject.org/wiki/Packaging:No_Bundled_Libraries"
	fi
}
