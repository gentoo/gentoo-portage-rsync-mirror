# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mytop/mytop-1.6-r2.ebuild,v 1.1 2009/02/15 01:38:59 robbat2 Exp $

inherit perl-app

DESCRIPTION="mytop - a top clone for mysql"
HOMEPAGE="http://jeremy.zawodny.com/mysql/mytop/"
SRC_URI="http://jeremy.zawodny.com/mysql/mytop/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
SLOT="0"
IUSE=""

DEPEND="dev-perl/DBD-mysql
	virtual/perl-Getopt-Long
	dev-perl/TermReadKey
	virtual/perl-Term-ANSIColor
	virtual/perl-Time-HiRes
	>=sys-apps/sed-4"

PATCHES="${FILESDIR}/${P}-global-status.patch
		 ${FILESDIR}/${P}-queries-vs-questions-mysql-5.0.76.patch"

src_install() {
	perl-module_src_install
	sed -i -r\
		-e "s|socket( +)=> '',|socket\1=> '/var/run/mysqld/mysqld.sock',|g" \
		"${D}"/usr/bin/mytop
}
