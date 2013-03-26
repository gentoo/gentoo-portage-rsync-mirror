# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/leveldb/leveldb-1.9.0-r3.ebuild,v 1.1 2013/03/26 09:11:42 patrick Exp $
EAPI=4

PYTHON_DEPEND="2:2.6"
inherit eutils multilib

DESCRIPTION="A fast key-value storage library written at Google"

HOMEPAGE="http://code.google.com/p/leveldb/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

IUSE=""

DEPEND="app-arch/snappy"
RDEPEND="${DEPEND}"

src_compile() {
	emake all || die
	emake libmemenv.a || die
}

src_install() {
	mkdir -p "${D}/usr/include"
	cp -r include/* "${D}/usr/include" || die
	cp helpers/memenv/memenv.h "${D}/usr/include" || die
	dolib.so libleveldb.so.${PV/.0} || die
	dosym libleveldb$(get_libname ).1.9 /usr/$(get_libdir)/libleveldb$(get_libname ) || die
	dosym libleveldb$(get_libname ).1.9 /usr/$(get_libdir)/libleveldb$(get_libname ).1 || die
	dolib.a libleveldb.a || die
	dolib.a libmemenv.a || die
}
