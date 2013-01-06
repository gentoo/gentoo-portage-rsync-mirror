# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ploop/ploop-1.5.ebuild,v 1.1 2012/12/10 12:59:49 pinkbyte Exp $

EAPI=5

inherit eutils toolchain-funcs multilib

DESCRIPTION="openvz tool and a library to control ploop block devices"
HOMEPAGE="http://wiki.openvz.org/Download/ploop"
SRC_URI="http://download.openvz.org/utils/ploop/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

DEPEND="dev-libs/libxml2"
RDEPEND="${DEPEND}"

DOCS=( tools/README )

src_prepare() {
	# Respect CFLAGS and CC
	sed -e 's|CFLAGS =|CFLAGS +=|' -e 's|CC=|CC?=|' \
		-i Makefile.inc || die 'sed on Makefile.inc failed'
	# Avoid striping of binaries
	sed -e '/INSTALL/{s: -s::}' -i tools/Makefile || die 'sed on tools/Makefile failed'

	epatch "${FILESDIR}/ploop-1.2-soname.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" V=1
}

src_install() {
	default
	ldconfig -n "${D}/usr/$(get_libdir)/" || die
	use static-libs || rm "${D}/usr/$(get_libdir)/libploop.a" || die 'remove static lib failed'
}

pkg_postinst() {
	elog "Warning - API changes"
	elog "1. This version requires running vzkernel >= 2.6.32-042stab061.1"
	elog "2. DiskDescriptor.xml created by older ploop versions are converted to current format"
}
