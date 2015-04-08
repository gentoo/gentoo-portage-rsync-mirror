# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-mysql/DBD-mysql-4.31.0.ebuild,v 1.1 2015/03/09 14:56:36 monsieurp Exp $

EAPI=5

MODULE_AUTHOR=CAPTTOFU
MODULE_VERSION=4.031
inherit eutils perl-module

DESCRIPTION="The Perl DBD:mysql Module"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="embedded test"

RDEPEND="dev-perl/DBI
	dev-perl/Test-Deep
	virtual/mysql[embedded?]"
DEPEND="${RDEPEND}"

if use test; then
	SRC_TEST="do"
else
	SRC_TEST="skip"
fi

src_configure() {
	if use test; then
		myconf="${myconf} --testdb=test \
			--testhost=localhost \
			--testuser=test \
			--testpassword=test"
	fi
	use embedded && myconf="${myconf} --force-embedded --embedded=mysql_config"
	perl-module_src_configure
}

src_test() {
	if use test; then
		einfo
		einfo "If tests fail, you have to configure your MySQL instance to create"
		einfo "and grant some privileges to the test user."
		einfo "You can run the following commands at the MySQL prompt: "
		einfo "> CREATE USER 'test'@'localhost' IDENTIFIED BY 'test';"
		einfo "> CREATE DATABASE test;"
		einfo "> GRANT ALL PRIVILEGES ON test.* TO 'test'@'localhost';"
		einfo
		sleep 5
		perl-module_src_test
	fi
}
