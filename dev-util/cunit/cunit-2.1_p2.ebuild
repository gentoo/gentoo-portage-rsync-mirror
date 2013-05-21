# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cunit/cunit-2.1_p2.ebuild,v 1.3 2013/05/21 20:15:33 jer Exp $

EAPI=5
inherit autotools eutils flag-o-matic

MY_PN='CUnit'
MY_PV="${PV/_p*}-2"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="CUnit - C Unit Test Framework"
SRC_URI="mirror://sourceforge/cunit/${MY_P}-src.tar.bz2"
HOMEPAGE="http://cunit.sourceforge.net"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="static-libs"

S=${WORKDIR}/${MY_P}

DOCS=( AUTHORS NEWS README ChangeLog )

src_prepare() {
	sed -e "/^docdir/d" -i doc/Makefile.am || die
	sed -e '/^dochdrdir/{s:$(prefix)/doc/@PACKAGE@:$(docdir):}' \
		-i doc/headers/Makefile.am || die
	sed -e "s/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/" -i configure.in || die
	eautoreconf
	append-cppflags -D_BSD_SOURCE
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--disable-debug \
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
}

src_install() {
	default
	prune_libtool_files
}
