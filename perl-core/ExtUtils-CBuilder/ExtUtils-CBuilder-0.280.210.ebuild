# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/ExtUtils-CBuilder/ExtUtils-CBuilder-0.280.210.ebuild,v 1.2 2014/02/26 09:52:41 zlogene Exp $

EAPI=5

MODULE_AUTHOR=AMBS
MODULE_VERSION=0.280210
MODULE_SECTION="ExtUtils"

inherit perl-module

DESCRIPTION="Compile and link C code for Perl modules"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="
	virtual/perl-File-Spec
	virtual/perl-File-Temp
	virtual/perl-IPC-Cmd
	virtual/perl-Perl-OSType"

DEPEND="${RDEPEND}"

SRC_TEST="do"
