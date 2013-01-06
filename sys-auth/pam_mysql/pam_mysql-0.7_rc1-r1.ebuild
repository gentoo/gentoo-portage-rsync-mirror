# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_mysql/pam_mysql-0.7_rc1-r1.ebuild,v 1.5 2007/04/18 18:31:34 opfer Exp $

inherit libtool multilib

DESCRIPTION="pam_mysql is a module for pam to authenticate users with mysql"
HOMEPAGE="http://pam-mysql.sourceforge.net/"

SRC_URI="mirror://sourceforge/pam-mysql/${P/_rc/RC}.tar.gz"
DEPEND=">=sys-libs/pam-0.72 virtual/mysql"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ~sparc x86"
IUSE="openssl"
S="${WORKDIR}/${P/_rc/RC}"

src_unpack() {
	unpack ${A}

	cd ${S}
	elibtoolize
}

src_compile() {
	local myconf
	myconf="${myconf} $(use_with openssl)"
	econf ${myconf}
	emake
}

src_install() {
	make DESTDIR=${D} libdir=$(get_libdir)/security install || die

	dodoc CREDITS ChangeLog NEWS README
}
