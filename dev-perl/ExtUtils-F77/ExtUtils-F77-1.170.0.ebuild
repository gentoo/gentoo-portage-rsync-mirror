# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-F77/ExtUtils-F77-1.170.0.ebuild,v 1.9 2013/02/08 19:55:59 bicatali Exp $

EAPI=4

MODULE_AUTHOR=KGB
MODULE_VERSION=1.17
inherit perl-module

DESCRIPTION="Facilitate use of FORTRAN from Perl/XS code"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc s390 sh sparc x86 ~amd64-linux ~x86-linux"
IUSE=""

SRC_TEST="do"
