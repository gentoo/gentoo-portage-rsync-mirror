# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mtop/mtop-0.6.6.ebuild,v 1.9 2007/07/13 06:38:59 mr_bones_ Exp $

inherit perl-app

DESCRIPTION="Mysql top monitors a MySQL server"
HOMEPAGE="http://mtop.sourceforge.net"
SRC_URI="mirror://sourceforge/mtop/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
DEPEND="dev-perl/Curses
		dev-perl/DBI
		dev-perl/DBD-mysql
		virtual/perl-libnet"

src_compile() {
	perl-app_src_prep || die "Perl module preparation failed."
	perl-app_src_compile || die "Perl module compilation failed."
	perl-module_src_test || die "Perl module tests failed."
}

src_install() {
	perl-module_src_install || die "Perl module installation failed."
	dodoc ChangeLog COPYING README README.devel
}
