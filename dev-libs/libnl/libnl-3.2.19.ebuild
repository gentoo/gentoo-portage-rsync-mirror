# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnl/libnl-3.2.19.ebuild,v 1.2 2013/05/21 16:40:25 jer Exp $

EAPI=4
inherit eutils libtool multilib

DESCRIPTION="A collection of libraries providing APIs to netlink protocol based Linux kernel interfaces"
HOMEPAGE="http://www.infradead.org/~tgr/libnl/"
SRC_URI="
	http://www.infradead.org/~tgr/${PN}/files/${P}.tar.gz
	doc? ( http://www.infradead.org/~tgr/${PN}/files/${PN}-doc-${PV}.tar.gz )
"
LICENSE="LGPL-2.1 doc? ( GPL-2 ) utils? ( GPL-2 )"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="doc static-libs utils"

DEPEND="
	sys-devel/flex
	sys-devel/bison
"

src_prepare() {
	elibtoolize
	epatch "${FILESDIR}"/${PN}-1.1-vlan-header.patch
}

src_configure() {
	econf \
		--disable-silent-rules \
		$(use_enable static-libs static) \
		$(use_enable utils cli)
}

src_install() {
	default
	if use doc; then
		dohtml -r \
			-a css,html,js,map,png \
			"${WORKDIR}"/${PN}-doc-${PV}/*
	fi

	prune_libtool_files $(usex static-libs --modules --all)

	dodoc ChangeLog
}
