# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/ideviceinstaller/ideviceinstaller-1.0.1.ebuild,v 1.3 2012/08/16 22:01:58 johu Exp $

EAPI=4

DESCRIPTION="A tool to interact with the installation_proxy of an Apple's iDevice"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=app-pda/libimobiledevice-1.1.4
	>=app-pda/libplist-1.8
	>=dev-libs/libzip-0.8"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS NEWS README"

src_prepare() {
	sed -i -e 's:-Werror -g::' configure || die
}
