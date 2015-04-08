# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/CGI/CGI-4.90.0.ebuild,v 1.1 2014/11/16 15:31:55 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=LEEJO
MODULE_VERSION=4.09
inherit perl-module

DESCRIPTION="Simple Common Gateway Interface Class"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="test"

RDEPEND="
	virtual/perl-Carp
	virtual/perl-Exporter
	virtual/perl-ExtUtils-MakeMaker
	>=virtual/perl-File-Spec-0.820.0
	virtual/perl-if
	>=virtual/perl-parent-0.225.0
"
DEPEND="${RDEPEND}
	test? ( >=virtual/perl-Test-Simple-0.980.0 )
"

#	dev-perl/FCGI" #236921

SRC_TEST="do"
