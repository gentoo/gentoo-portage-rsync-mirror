# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/tpb/tpb-0.6.4.ebuild,v 1.7 2010/01/01 20:54:45 ssuominen Exp $

inherit linux-info eutils

DESCRIPTION="IBM ThinkPad buttons utility"
HOMEPAGE="http://savannah.nongnu.org/projects/tpb/"
SRC_URI="http://savannah.nongnu.org/download/tpb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 -ppc x86"
IUSE="nls xosd"

DEPEND="x11-libs/libXt
	x11-libs/libXext
	xosd? ( >=x11-libs/xosd-2.2.0 )"

CONFIG_CHECK="~NVRAM"
ERROR_NVRAM="${P} requires /dev/nvram support (CONFIG_NVRAM)"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-configure-fix.diff
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable xosd)
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc README ChangeLog CREDITS TODO
	dodoc doc/{callback_example.sh,nvram.txt,tpbrc}
}
