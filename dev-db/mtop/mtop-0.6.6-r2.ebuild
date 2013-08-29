# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mtop/mtop-0.6.6-r2.ebuild,v 1.1 2013/08/29 15:44:33 idella4 Exp $

EAPI=5
inherit perl-app

DESCRIPTION="Mysql top monitors a MySQL server"
HOMEPAGE="http://mtop.sourceforge.net"
SRC_URI="mirror://sourceforge/mtop/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="dev-perl/Curses
		dev-perl/DBI
		dev-perl/DBD-mysql
		virtual/perl-libnet"

src_prepare() {
	epatch "${FILESDIR}"/mtop-0.6.6-globalstatusfix.patch
}

src_prepare() {
	perl-app_src_prep || die "Perl module preparation failed."
}

src_compile() {
	perl-app_src_compile || die "Perl module compilation failed."
}

src_test() {
	perl-module_src_test || die "Perl module tests failed."
}

src_install() {
	perl-module_src_install || die "Perl module installation failed."
	dodoc ChangeLog README README.devel
}

warnmsg() {
	einfo "Upstream no longer maintains mtop. You should consider dev-db/mytop instead."
}

pkg_postinst() {
	warnmsg
}

pkg_preinst() {
	warnmsg
}
