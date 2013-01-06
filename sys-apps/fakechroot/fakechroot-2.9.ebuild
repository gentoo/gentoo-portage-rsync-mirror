# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fakechroot/fakechroot-2.9.ebuild,v 1.4 2010/05/03 08:59:45 ssuominen Exp $

inherit autotools eutils

DESCRIPTION="Provide a faked chroot environment without requiring root privileges"
HOMEPAGE="http://fakechroot.alioth.debian.org/"
SRC_URI="mirror://debian/pool/main/f/fakechroot/${PF/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=""
DEPEND=""

RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-glibc-2.10-compat.patch
	AT_M4DIR="m4" eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README THANKS
}
