# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-mysql/DBD-mysql-4.20.0.ebuild,v 1.10 2013/08/18 13:25:36 ago Exp $

EAPI=4

MODULE_AUTHOR=CAPTTOFU
MODULE_VERSION=4.020
inherit eutils perl-module

DESCRIPTION="The Perl DBD:mysql Module"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="embedded"

RDEPEND="dev-perl/DBI
	virtual/mysql[embedded?]"
DEPEND="${RDEPEND}"

mydoc="ToDo"

src_configure() {
	use embedded && myconf="${myconf} --force-embedded --embedded=mysql_config"
	perl-module_src_configure
}
