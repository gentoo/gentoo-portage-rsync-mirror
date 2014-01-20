# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/ExtUtils-ParseXS/ExtUtils-ParseXS-2.22.06.ebuild,v 1.6 2014/01/20 20:58:16 vapier Exp $

EAPI=3

inherit versionator
MY_P=${PN}-$(delete_version_separator 2 )
MODULE_VERSION=2.2206
S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=DAGOLDEN
inherit perl-module

DESCRIPTION="Converts Perl XS code into C code"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-CBuilder"

SRC_TEST="do"
