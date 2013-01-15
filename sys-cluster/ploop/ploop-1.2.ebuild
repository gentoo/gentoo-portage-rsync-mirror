# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ploop/ploop-1.2.ebuild,v 1.2 2013/01/15 11:44:41 pinkbyte Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="openvz tool and a library to control ploop block devices"
HOMEPAGE="http://wiki.openvz.org/Download/ploop"
SRC_URI="http://download.openvz.org/utils/ploop/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/libxml2"
RDEPEND="${DEPEND}"

src_prepare() {
	# Respect CFLAGS and CC
	sed -e 's|CFLAGS =|CFLAGS +=|' -e "s|\(CC=\).*|\1$(tc-getCC)|" \
		-i Makefile.inc || die
	# Avoid striping of binaries
	sed -e '/INSTALL/{s: -s::}' -i tools/Makefile || die
	epatch "${FILESDIR}/ploop-1.2-soname.patch"

	# respect AR and RANLIB, bug #452092
	tc-export AR RANLIB
	sed -i -e 's/ranlib/$(RANLIB)/' lib/Makefile || die 'sed on lib/Makefile failed'
}

src_compile() {
	emake V=1
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc tools/README
	ldconfig -n "${D}/usr/lib/" || die
}
