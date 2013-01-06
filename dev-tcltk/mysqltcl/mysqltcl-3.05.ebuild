# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/mysqltcl/mysqltcl-3.05.ebuild,v 1.7 2013/01/04 15:49:51 ulm Exp $

EAPI=4

inherit eutils multilib

DESCRIPTION="TCL MySQL Interface"
HOMEPAGE="http://www.xdobry.de/mysqltcl/"
SRC_URI="http://www.xdobry.de/mysqltcl/${P}.tar.gz"

LICENSE="HPND"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="
	dev-lang/tcl
	>=virtual/mysql-4.1"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-ldflags.patch
	sed -i 's/-pipe//g;s/-O2//g;s/-fomit-frame-pointer//g' configure || die
}

src_configure() {
	econf --with-mysql-lib=/usr/$(get_libdir)/mysql
}

src_install() {
	default
	dohtml doc/mysqltcl.html
}
