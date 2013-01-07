# Copyright 1999-2013 GentooFoundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xssstate/xssstate-1.0.20130103.ebuild,v 1.5 2013/01/07 02:35:58 jdhore Exp $

EAPI=5
inherit eutils toolchain-funcs

DESCRIPTION="A simple tool to retrieve the X screensaver state"
HOMEPAGE="http://tools.suckless.org/xssstate"
SRC_URI="http://dev.gentoo.org/~jer/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	x11-libs/libX11
	x11-libs/libXScrnSaver
"
DEPEND="
	${RDEPEND}
	app-arch/xz-utils
	x11-proto/scrnsaverproto
	x11-proto/xproto
"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" PREFIX='/usr' install
	dodoc README xsidle.sh
}
