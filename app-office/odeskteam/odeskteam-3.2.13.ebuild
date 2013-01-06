# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/odeskteam/odeskteam-3.2.13.ebuild,v 1.1 2012/04/01 16:47:39 titanofold Exp $

EAPI=4

inherit eutils

# Binary only distribution
QA_PREBUILT="*"

DESCRIPTION="Project collaboration and tracking software for oDesk.com"
HOMEPAGE="https://www.odesk.com/"
SRC_URI="amd64? ( https://www.odesk.com/downloads/linux/${P}-1-x86_64.pkg.tar.xz )
		 x86? ( https://www.odesk.com/downloads/linux/${P}-1-i686.pkg.tar.xz )
"

LICENSE="ODESK"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="v4l"

S=${WORKDIR}

RDEPEND=">=dev-libs/glib-2
		 >=x11-libs/libnotify-0.7
		 app-arch/bzip2
		 dev-libs/expat
		 dev-libs/libxml2
		 dev-libs/openssl:0
		 media-libs/gst-plugins-base:0.10
		 media-libs/gstreamer:0.10
		 sys-apps/util-linux
		 sys-libs/zlib
		 virtual/libffi
		 x11-libs/gdk-pixbuf
		 x11-libs/libX11
		 x11-libs/libXScrnSaver
		 x11-libs/libXau
		 x11-libs/libXdmcp
		 x11-libs/libXext
		 x11-libs/libxcb
		 x11-libs/qt-core:4[ssl]
		 x11-libs/qt-dbus:4
		 x11-libs/qt-gui:4
		 v4l? (
			 media-libs/gst-plugins-good:0.10
			 media-plugins/gst-plugins-libpng:0.10
			 media-plugins/gst-plugins-v4l2:0.10
			 media-plugins/gst-plugins-xvideo:0.10
		 )
"

DEPEND="app-arch/xz-utils"

src_install() {
	into /opt
	dobin usr/bin/{odeskteam-qt4,ot-alert}

	domenu usr/share/applications/odeskteam.desktop

	doicon usr/share/pixmaps/odeskteam.png
}
