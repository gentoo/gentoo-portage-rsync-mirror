# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Module-Metadata/Module-Metadata-1.0.6.ebuild,v 1.8 2012/05/15 19:11:59 halcy0n Exp $

EAPI=4

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=1.000006
inherit perl-module

DESCRIPTION="Gather package and POD information from perl module files"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=virtual/perl-version-0.870"
DEPEND="${RDEPEND}"

SRC_TEST="do"
