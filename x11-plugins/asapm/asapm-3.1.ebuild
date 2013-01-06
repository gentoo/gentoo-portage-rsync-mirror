# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/asapm/asapm-3.1.ebuild,v 1.6 2012/11/27 13:46:16 ago Exp $

inherit toolchain-funcs

DESCRIPTION="APM monitor for AfterStep"
SRC_URI="http://www.tigr.net/afterstep/download/asapm/${P}.tar.gz"
HOMEPAGE="http://www.tigr.net/afterstep/list.pl"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc -sparc x86"
IUSE="jpeg"

RDEPEND="x11-libs/libXpm
	x11-libs/libSM
	jpeg? ( virtual/jpeg )"

DEPEND="${RDEPEND}
	x11-proto/xproto"

src_compile() {
	econf $(use_enable jpeg) || die "econf failed"
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin asapm
	newman asapm.man asapm.1
	dodoc CHANGES README TODO NOTES
}
