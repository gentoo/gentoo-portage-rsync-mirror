# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/djmount/djmount-0.71-r1.ebuild,v 1.4 2010/10/12 08:40:57 phajdan.jr Exp $

EAPI="2"

DESCRIPTION="Mount UPnP audio/video servers as a filesystem"
HOMEPAGE="http://djmount.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug test"

RDEPEND="sys-fs/fuse
	net-libs/libupnp"
DEPEND="${RDEPEND}
	test? ( sys-libs/readline )"

src_unpack() {
	default
	rm -rf libupnp/*/{src,inc} libupnp/configure # make sure we use external
}

src_prepare() {
	sed -i 's:SetLogFileNames:UpnpSetLogFileNames:' djmount/fuse_main.c #267508
	sed -i 's:InitLog:UpnpInitLog:' djmount/test_device.c #277557
}

src_configure() {
	econf $(use_enable debug) --with-external-libupnp
}

src_test() {
	# wants to do mounts :x
	printf '#!/bin/sh\nexit 0\n' > djmount/test_vfs.sh
	default
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README search_help.txt THANKS
}
