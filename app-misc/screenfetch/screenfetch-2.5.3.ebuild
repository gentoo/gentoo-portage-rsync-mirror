# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/screenfetch/screenfetch-2.5.3.ebuild,v 1.1 2012/09/17 20:17:33 hwoarang Exp $

EAPI=4

MY_PN="${PN/f/F}"
DESCRIPTION="A Bash Screenshot Information Tool"
HOMEPAGE="https://github.com/KittyKatt/screenFetch"
SRC_URI="http://github.com/KittyKatt/${MY_PN}/zipball/v${PV} -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="media-gfx/scrot
	x11-apps/xdpyinfo"

GIT_HASH="9d5d97e"
S="${WORKDIR}"/KittyKatt-${MY_PN}-${GIT_HASH}

src_install() {
	dobin ${PN}-dev
	# also known as screenfetch
	dosym ${PN}-dev /usr/bin/${PN}
	dodoc CHANGELOG README.mkdn TODO
}
