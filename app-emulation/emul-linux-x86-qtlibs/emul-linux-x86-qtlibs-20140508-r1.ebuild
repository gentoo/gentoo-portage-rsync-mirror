# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-qtlibs/emul-linux-x86-qtlibs-20140508-r1.ebuild,v 1.1 2014/05/27 19:06:38 mgorny Exp $

EAPI=5
inherit eutils emul-linux-x86

LICENSE="LGPL-2.1 GPL-3"
KEYWORDS="-* ~amd64"

IUSE="mng"

DEPEND=""
RDEPEND="
	|| (
		~app-emulation/emul-linux-x86-baselibs-${PV}
		(
			dev-db/sqlite:3[abi_x86_32(-)]
			dev-libs/glib[abi_x86_32(-)]
			dev-libs/openssl[abi_x86_32(-)]
			mng? ( <media-libs/libmng-2[abi_x86_32(-)] )
			media-libs/libpng:0/16[abi_x86_32(-)]
			media-libs/tiff[abi_x86_32(-)]
			sys-apps/dbus[abi_x86_32(-)]
			sys-libs/zlib[abi_x86_32(-)]
			virtual/jpeg:62[abi_x86_32(-)]
		)
	)
	|| (
		~app-emulation/emul-linux-x86-medialibs-${PV}
		(
			media-libs/gstreamer:0.10[abi_x86_32(-)]
			media-libs/gst-plugins-base:0.10[abi_x86_32(-)]
		)
	)
	|| (
		~app-emulation/emul-linux-x86-opengl-${PV}
		virtual/opengl[abi_x86_32(-)]
	)
	|| (
		~app-emulation/emul-linux-x86-xlibs-${PV}
		(
			media-libs/fontconfig[abi_x86_32(-)]
			media-libs/freetype[abi_x86_32(-)]
			x11-libs/libICE[abi_x86_32(-)]
			x11-libs/libSM[abi_x86_32(-)]
			x11-libs/libX11[abi_x86_32(-)]
			x11-libs/libXcursor[abi_x86_32(-)]
			x11-libs/libXext[abi_x86_32(-)]
			x11-libs/libXfixes[abi_x86_32(-)]
			x11-libs/libXinerama[abi_x86_32(-)]
			x11-libs/libXi[abi_x86_32(-)]
			x11-libs/libXrandr[abi_x86_32(-)]
			x11-libs/libXrender[abi_x86_32(-)]
		)
	)"

src_install() {
	emul-linux-x86_src_install

	if ! use mng; then
		rm "${D%/}"/usr/lib32/qt4/plugins/imageformats/libqmng.so || die
	fi

	# Set LDPATH for not needing dev-qt/qtcore
	cat <<-EOF > "${T}/44qt4-emul"
	LDPATH=/usr/lib32/qt4
	EOF
	doenvd "${T}/44qt4-emul"
}
