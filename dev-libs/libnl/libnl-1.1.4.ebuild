# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnl/libnl-1.1.4.ebuild,v 1.1 2013/05/07 21:42:52 jer Exp $

EAPI=5
inherit eutils multilib toolchain-funcs

DESCRIPTION="A library for applications dealing with netlink socket"
HOMEPAGE="http://www.infradead.org/~tgr/libnl/"
SRC_URI="http://www.infradead.org/~tgr/libnl/files/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="1.1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"
DOCS=( ChangeLog )

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-1.1-vlan-header.patch \
		"${FILESDIR}"/${PN}-1.1-flags.patch \
		"${FILESDIR}"/${PN}-1.1.3-offsetof.patch
	sed -i \
		-e '/@echo/d' \
		Makefile.rules {lib,src,tests}/Makefile || die
	sed -i \
		-e 's|-g ||g' \
		Makefile.opts.in || die
}

src_compile() {
	emake AR=$(tc-getAR)

	if use doc ; then
		cd "${S}/doc"
		emake gendoc || die
	fi
}

src_install() {
	default

	if use doc ; then
		cd "${S}/doc"
		dohtml -r html/*
	fi
}
