# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Symdump/Devel-Symdump-2.80.0.ebuild,v 1.5 2012/10/09 01:20:37 blueness Exp $

EAPI=4

MODULE_AUTHOR=ANDK
MODULE_VERSION=2.08
inherit versionator perl-module

DESCRIPTION="Dump symbol names or the symbol table"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

SRC_TEST="do"
