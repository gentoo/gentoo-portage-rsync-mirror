# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/hostap-utils/hostap-utils-0.4.7.ebuild,v 1.5 2009/09/23 19:52:25 patrick Exp $

inherit toolchain-funcs

DESCRIPTION="Utilities for Intersil Prism2/2.5/3 based IEEE 802.11b wireless LAN products"

HOMEPAGE="http://hostap.epitest.fi/"
SRC_URI="http://hostap.epitest.fi/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

IUSE=""

DEPEND=""

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dosbin hostap_{crypt_conf,diag,fw_load,io_debug,rid}
	dosbin prism2_{param,srec}
	dosbin split_combined_hex

	dodoc README
}
