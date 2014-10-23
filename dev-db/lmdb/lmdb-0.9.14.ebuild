# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/lmdb/lmdb-0.9.14.ebuild,v 1.1 2014/10/23 11:57:40 eras Exp $

EAPI=5
inherit toolchain-funcs

DESCRIPTION="An ultra-fast, ultra-compact key-value embedded data store"
HOMEPAGE="http://symas.com/mdb/"
SRC_URI="https://gitorious.org/mdb/mdb/archive/2f587ae081d076e3707360c5db086520c219d3ea.tar.gz
	-> lmdb-0.9.14.tar.gz"

LICENSE="OPENLDAP"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~x86"
IUSE="static-libs"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/mdb-mdb/libraries/liblmdb"

src_prepare() {
	sed -i -e "s/^CC.*/CC = $(tc-getCC)/" \
		-e "s/^CFLAGS.*/CFLAGS = ${CFLAGS}/" \
		-e "s/ar rs/$(tc-getAR) rs/" \
		-e "s:^prefix.*:prefix = /usr:" \
		-e "s:/man/:/share/man/:" \
		-e "/for f/s:lib:$(get_libdir):" \
		-e "s:shared:shared -Wl,-soname,liblmdb.so.0:" \
		"${S}/Makefile" || die
}

src_configure() {
	:
}

src_compile() {
	emake LDLIBS+=" -pthread"
}

src_install() {
	mkdir -p "${D}"/usr/{bin,$(get_libdir),include,share/man/man1}
	default

	mv "${D}"/usr/$(get_libdir)/liblmdb.so{,.0} || die
	dosym liblmdb.so.0 /usr/$(get_libdir)/liblmdb.so

	use static-libs || rm -f "${D}"/usr/$(get_libdir)/liblmdb.a
}
