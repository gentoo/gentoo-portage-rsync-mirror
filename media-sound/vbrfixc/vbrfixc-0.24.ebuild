# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vbrfixc/vbrfixc-0.24.ebuild,v 1.5 2009/08/21 16:03:38 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="Vbrfix fixes MP3s and re-constructs VBR headers"
HOMEPAGE="http://www.willwap.co.uk/Programs/vbrfix.php"
SRC_URI="http://www.willwap.co.uk/Downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
# bin endian ones need vbrfixc-0.24-bigendian.diff from gentoo-x86 cvs Attic
KEYWORDS="amd64 x86"
IUSE=""
DEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch

}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README TODO
	dohtml vbrfixc/docs/en/*.html
}
