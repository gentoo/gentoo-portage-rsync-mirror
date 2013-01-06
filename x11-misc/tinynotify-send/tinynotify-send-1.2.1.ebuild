# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/tinynotify-send/tinynotify-send-1.2.1.ebuild,v 1.4 2012/08/31 08:25:22 mgorny Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="A notification sending utility (using libtinynotify)"
HOMEPAGE="https://bitbucket.org/mgorny/tinynotify-send/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="symlink"

RDEPEND="x11-libs/libtinynotify
	~x11-libs/libtinynotify-cli-${PV}
	symlink? ( !x11-libs/libnotify[symlink] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	myeconfargs=(
		--disable-library
		--enable-regular
		--disable-system-wide
		--with-system-wide-exec=/usr/bin/sw-notify-send
	)

	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	use symlink && dosym tinynotify-send /usr/bin/notify-send
}
