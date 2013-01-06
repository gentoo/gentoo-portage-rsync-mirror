# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce-theme-manager/xfce-theme-manager-0.1.20.ebuild,v 1.1 2012/12/11 11:54:48 ssuominen Exp $

EAPI=5
inherit toolchain-funcs xfconf

MY_P=Xfce-Theme-Manager-${PV}

DESCRIPTION="An alternative theme manager for The Xfce Desktop Environment"
HOMEPAGE="http://keithhedger.hostingsiteforfree.com/pages/apps.html#themeed"
SRC_URI="http://keithhedger.hostingsiteforfree.com/zips/xfcethememanager/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-libs/libXcursor
	>=xfce-base/libxfce4ui-4.10"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-build.patch )
	DOCS=( ChangeLog README README.de README.es )
	tc-export CXX
}

src_configure() { :; }
