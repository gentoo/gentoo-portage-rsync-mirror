# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/XSLoader/XSLoader-0.160.0-r1.ebuild,v 1.1 2014/07/25 21:02:09 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=SAPER
MODULE_VERSION=0.16
inherit perl-module

DESCRIPTION="Dynamically load C libraries into Perl code"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~x86-freebsd ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

SRC_TEST=do
