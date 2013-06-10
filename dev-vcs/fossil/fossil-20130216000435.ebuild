# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/fossil/fossil-20130216000435.ebuild,v 1.2 2013/06/10 11:34:14 nimiux Exp $

EAPI="4"

MY_P="${PN}-src-${PV}"

DESCRIPTION="Simple, high-reliability, source control management, and more"
HOMEPAGE="http://www.fossil-scm.org/"
SRC_URI="http://www.fossil-scm.org/download/${MY_P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="json -sqlite +ssl tcl"

DEPEND="sys-libs/zlib
		ssl? ( dev-libs/openssl )
		sqlite? ( dev-db/sqlite:3 )
		tcl? ( dev-lang/tcl )
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	# --with-tcl: works
	# --without-tcl: dies
	local myconf='--with-zlib --markdown'
	use json   && myconf+=' --json'
	use sqlite && myconf+=' --disable-internal-sqlite'
	use ssl    && myconf+=' --with-openssl'
	use tcl    && myconf+=' --with-tcl --with-tcl-stubs'
	econf ${myconf}
}

src_install() {
	dobin fossil
}
