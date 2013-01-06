# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/gigabase/gigabase-3.83.ebuild,v 1.1 2011/10/02 09:17:21 pva Exp $

inherit eutils multilib

DESCRIPTION="OO-DBMS with interfaces for C/C++/Java/PHP/Perl"
HOMEPAGE="http://www.garret.ru/~knizhnik/gigabase.html"
SRC_URI="mirror://sourceforge/gigabase/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

S=${WORKDIR}/gigabase

src_compile() {
	mf="${S}/Makefile"

	econf
	sed -r -i -e 's/subsql([^\.]|$)/subsql-gdb\1/' ${mf}
	emake || die "compilation failed"
	use doc && { doxygen doxygen.cfg || die "doxygen failed"; }
}

src_install() {
	einstall || die "make install failed"

	dodoc CHANGES
	use doc && dohtml GigaBASE.htm
	use doc && dohtml -r docs/html/*
}

pkg_postinst() {
	elog "The subsql binary has been renamed to subsql-gdb,"
	elog "to avoid a name clash with the FastDB version of subsql"
}
