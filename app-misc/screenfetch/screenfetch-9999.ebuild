# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/screenfetch/screenfetch-9999.ebuild,v 1.1 2013/08/30 23:52:45 hwoarang Exp $

EAPI=4

MY_PN="${PN/f/F}"
DESCRIPTION="A Bash Screenshot Information Tool"
HOMEPAGE="https://github.com/KittyKatt/screenFetch"
if [[ ${PV} == *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="https://github.com/KittyKatt/screenFetch"
	KEYWORDS=""
else
	SRC_URI="https://github.com/KittyKatt/${MY_PN}/archive/v${PV}.tar.gz -> \
		${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_PN}-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="media-gfx/scrot
	x11-apps/xdpyinfo"

src_install() {
	dobin ${PN}-dev
	# also known as screenfetch
	dosym ${PN}-dev /usr/bin/${PN}
	dodoc CHANGELOG README.mkdn TODO
}
