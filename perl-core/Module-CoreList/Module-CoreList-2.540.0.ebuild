# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Module-CoreList/Module-CoreList-2.540.0.ebuild,v 1.6 2011/11/07 17:36:34 xarthisius Exp $

EAPI=4

MODULE_AUTHOR=BINGOS
MODULE_VERSION=2.54
inherit perl-module

DESCRIPTION="what modules shipped with versions of perl"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

#RDEPEND=""
#DEPEND="test? ( dev-perl/Test-Pod )"

SRC_TEST=do
