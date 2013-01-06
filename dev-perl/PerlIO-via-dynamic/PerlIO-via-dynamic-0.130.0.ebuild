# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PerlIO-via-dynamic/PerlIO-via-dynamic-0.130.0.ebuild,v 1.5 2012/03/25 16:58:10 armin76 Exp $

EAPI=4

MODULE_AUTHOR=CLKAO
MODULE_VERSION=0.13
inherit perl-module

DESCRIPTION="PerlIO::via::dynamic - dynamic PerlIO layers"

SLOT="0"
KEYWORDS="alpha amd64 ~mips ~ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND=">=virtual/perl-File-Temp-0.14"
DEPEND="${RDEPEND}"

SRC_TEST="do"
