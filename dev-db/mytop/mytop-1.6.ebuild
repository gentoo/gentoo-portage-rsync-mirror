# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mytop/mytop-1.6.ebuild,v 1.3 2008/11/18 16:01:44 tove Exp $

inherit perl-app

DESCRIPTION="mytop - a top clone for mysql"
HOMEPAGE="http://jeremy.zawodny.com/mysql/mytop/"
SRC_URI="http://jeremy.zawodny.com/mysql/mytop/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ppc sparc x86"
SLOT="0"
IUSE=""

DEPEND="dev-perl/DBD-mysql
	virtual/perl-Getopt-Long
	dev-perl/TermReadKey
	virtual/perl-Term-ANSIColor
	virtual/perl-Time-HiRes
	>=sys-apps/sed-4"

src_install() {
	perl-module_src_install
	sed -i -r\
		-e "s|socket( +)=> '',|socket\1=> '/var/run/mysqld/mysqld.sock',|g" \
		"${D}"/usr/bin/mytop
}
