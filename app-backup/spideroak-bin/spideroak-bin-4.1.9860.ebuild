# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/spideroak-bin/spideroak-bin-4.1.9860.ebuild,v 1.4 2011/12/14 18:18:10 ago Exp $

EAPI=4

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
KEYWORDS="amd64 x86"
IUSE="dbus headless qt-bundled"

RDEPEND=">=dev-libs/glib-2.12.0
	dbus? ( sys-apps/dbus )
	>=sys-devel/gcc-4
	>=sys-libs/glibc-2.7
	!headless? (
		>=media-libs/fontconfig-2.4.0
		>=media-libs/freetype-2.3.5
		>=x11-libs/libICE-1.0.0
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXrender
		!qt-bundled? ( x11-libs/qt-gui:4[accessibility,dbus] )
	)"
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	unpack ./data.tar.gz
	rm -f control.tar.gz data.tar.gz debian-binary
}

src_prepare() {
	# change /usr/ to /opt/SpiderOak/ in start script
	sed -i 's:/usr/lib:/opt:g' usr/bin/SpiderOak || die "sed failed"
	# change /usr/ to /opt/ in .desktop file
	sed -i 's:/usr/bin/SpiderOak:/opt/bin/SpiderOak:g' usr/share/applications/spideroak.desktop || die "sed failed"

	# disable GUI if headless useflag is enabled
	if use headless; then
		sed -i 's:"$@":--headless "$@":' usr/bin/SpiderOak || die "sed failed"
	fi

	# remove shipped libstdc++.so.6 as it does not provide LIBCXX_3.4.11
	# and it seems to work alright with the one from >=gcc-4
	rm usr/lib/SpiderOak/libstdc++.so.6 || die "rm libstdc++.so.6 failed"

	if ! use qt-bundled || use headless; then
		# rm precompiled and bundled qt libs
		rm usr/lib/SpiderOak/libQt*.so.4 || die "rm libQt*.so.4 failed"
	fi
}

src_install() {
	insinto /opt/SpiderOak
	doins -r usr/lib/SpiderOak/*

	exeinto /opt/SpiderOak
	doexe usr/lib/SpiderOak/SpiderOak

	exeinto /opt/bin
	doexe usr/bin/SpiderOak

	if use dbus; then
		insinto /etc/dbus-1
		doins -r etc/dbus-1/*
	fi

	if ! use headless; then
		domenu usr/share/applications/spideroak.desktop
		doicon usr/share/pixmaps/spideroak.png
	fi
}

pkg_postinst() {
	if use headless ; then
		einfo "For instructions on running SpiderOak without a GUI, please read the FAQ:"
		einfo "  https://spideroak.com/faq/questions/62/how_do_i_install_spideroak_on_a_headless_linux_server/"
		einfo "  https://spideroak.com/faq/questions/67/how_can_i_use_spideroak_from_the_commandline/"
	fi
}
