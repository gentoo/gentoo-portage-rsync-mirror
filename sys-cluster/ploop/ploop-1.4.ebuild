# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ploop/ploop-1.4.ebuild,v 1.5 2013/05/02 13:53:30 pinkbyte Exp $

EAPI=4

inherit eutils toolchain-funcs multilib

DESCRIPTION="openvz tool and a library to control ploop block devices"
HOMEPAGE="http://wiki.openvz.org/Download/ploop"
SRC_URI="http://download.openvz.org/utils/ploop/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libxml2"
RDEPEND="${DEPEND}"

src_prepare() {
	# Respect CFLAGS and CC, do not add debug by default
	sed -i \
		-e 's|CFLAGS =|CFLAGS +=|' \
		-e '/CFLAGS/s/-g -O0 //' \
		-e '/CFLAGS/s/-O2//' \
		-e 's|CC=|CC?=|' \
		-e 's/-Werror//' \
		-e '/DEBUG=yes/d' \
		Makefile.inc || die 'sed on Makefile.inc failed'
	# Avoid striping of binaries
	sed -e '/INSTALL/{s: -s::}' -i tools/Makefile || die 'sed on tools/Makefile failed'

	epatch "${FILESDIR}/ploop-1.2-soname.patch"

	# respect AR and RANLIB, bug #452092
	tc-export AR RANLIB
	sed -i -e 's/ranlib/$(RANLIB)/' lib/Makefile || die 'sed on lib/Makefile failed'
}

src_compile() {
	emake CC="$(tc-getCC)" V=1
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc tools/README
	ldconfig -n "${D}/usr/$(get_libdir)/" || die
}
