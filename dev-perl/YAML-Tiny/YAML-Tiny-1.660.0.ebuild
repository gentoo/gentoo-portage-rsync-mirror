# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/YAML-Tiny/YAML-Tiny-1.660.0.ebuild,v 1.1 2015/03/22 16:40:25 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=ETHER
MODULE_VERSION=1.66
inherit perl-module

DESCRIPTION="Read/Write YAML files with as little code as possible"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="test"

RDEPEND="
	virtual/perl-Carp
	virtual/perl-Exporter
	virtual/perl-Scalar-List-Utils
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? (
		>=virtual/perl-File-Spec-0.80.0
		>=virtual/perl-File-Temp-0.180.0
		virtual/perl-Getopt-Long
		virtual/perl-IO
		virtual/perl-JSON-PP
		>=virtual/perl-Test-Simple-0.990.0
	)
"

SRC_TEST=do
