# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/i3status/i3status-2.7.ebuild,v 1.1 2013/02/27 10:56:44 xarthisius Exp $

EAPI=5

inherit toolchain-funcs versionator fcaps

DESCRIPTION="generates a status bar for dzen2, xmobar or similar"
HOMEPAGE="http://i3wm.org/i3status/"
SRC_URI="http://i3wm.org/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/confuse
	>=dev-libs/yajl-2.0.2
	media-libs/alsa-lib
	net-wireless/wireless-tools"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -e "/@echo/d" -e "s:@\$(:\$(:g" -e "/setcap/d" \
		-e '/CFLAGS+=-g/d' -i Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)"
}

pkg_postinst() {
	fcaps cap_net_admin usr/bin/${PN}
	elog "You need to install x11-misc/xmobar or x11-misc/dzen to use ${PN}."
	elog "Please refer to manual: man ${PN}"
}
