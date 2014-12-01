# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lsw/lsw-0.3.ebuild,v 1.1 2014/12/01 13:00:39 jer Exp $

EAPI="4"

inherit toolchain-funcs

DESCRIPTION="list window names"
HOMEPAGE="http://tools.suckless.org/lsw"
SRC_URI="http://dl.suckless.org/tools/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xproto"

src_prepare() {
	sed -i config.mk \
		-e '/^CC/d' \
		-e '/^CFLAGS/{s| -Os||;s|=|+=|}' \
		-e '/^LDFLAGS/{s|=|+=|;s| -s||}' || die
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	doman ${PN}.1
	dobin ${PN}
}
