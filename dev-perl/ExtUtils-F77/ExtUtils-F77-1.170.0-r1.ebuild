# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-F77/ExtUtils-F77-1.170.0-r1.ebuild,v 1.1 2014/08/22 17:51:12 axs Exp $

EAPI=5

MODULE_AUTHOR=KGB
MODULE_VERSION=1.17
inherit perl-module

DESCRIPTION="Facilitate use of FORTRAN from Perl/XS code"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc s390 sh sparc x86 ~amd64-linux ~x86-linux"
IUSE=""

SRC_TEST="do"
