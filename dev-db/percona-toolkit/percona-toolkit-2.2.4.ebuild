# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/percona-toolkit/percona-toolkit-2.2.4.ebuild,v 1.1 2013/10/12 23:38:34 idl0r Exp $

EAPI=5

inherit perl-app perl-module toolchain-funcs

DESCRIPTION="essential command-line utilities for MySQL"
HOMEPAGE="http://www.percona.com/software/percona-toolkit/"
SRC_URI="http://www.percona.com/downloads/${PN}/${PV}/${P}.tar.gz"

LICENSE="|| ( GPL-2 Artistic )"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
# Package warrants IUSE doc
IUSE=""

COMMON_DEPEND="dev-perl/DBI
	dev-perl/DBD-mysql
	virtual/perl-Time-HiRes"
RDEPEND="${COMMON_DEPEND}
	dev-perl/JSON
	dev-perl/libwww-perl
	dev-perl/Role-Tiny
	virtual/perl-File-Path
	virtual/perl-Getopt-Long
	virtual/perl-Time-Local
	virtual/perl-Digest-MD5
	virtual/perl-IO-Compress
	virtual/perl-File-Temp
	virtual/perl-File-Spec
	virtual/perl-Scalar-List-Utils
	dev-perl/TermReadKey"
DEPEND="${COMMON_DEPEND}
	virtual/perl-ExtUtils-MakeMaker"

# Percona Toolkit does NOT contain the UDF code for Murmur/FNV any more.
src_install() {
	perl-module_src_install
	dodoc docs/percona-toolkit.pod
}
