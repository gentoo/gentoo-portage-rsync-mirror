# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmldonkey/wmmldonkey-0.003.ebuild,v 1.7 2012/02/15 09:51:41 voyageur Exp $

DESCRIPTION="wmmsg is a dockapp to show the up and downloadrate from your mldonkey"
HOMEPAGE="http://dockapps.windowmaker.org/file.php/id/174"
SRC_URI="http://dockapps.windowmaker.org/download.php/id/298/wmmldonkey3.tar.gz"
LICENSE="GPL-1"
SLOT="0"
KEYWORDS="x86"
IUSE=""
S=${WORKDIR}/wmmldonkey3

RDEPEND="x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	net-p2p/mldonkey"

src_unpack()
{
	unpack ${A}

	sed -e 's:gcc:gcc ${CFLAGS}:' \
		-e 's:gui_protocol.o endianess.o::' \
		-e 's:main.c -o wmmldonkey:main.c gui_protocol.o endianess.o -o wmmldonkey:' \
		-e 's:-lXpm -lXext:-lX11 -lXpm -lXext:' \
		-i "${S}/Makefile"
}

src_install()
{
	dodoc CHANGELOG README
	exeinto /usr/bin
	doexe wmmldonkey
}

pkg_postinst()
{
	einfo "Make sure the mldonkey daemon is running before you"
	einfo "attempt to run emmldonkey..."
}
