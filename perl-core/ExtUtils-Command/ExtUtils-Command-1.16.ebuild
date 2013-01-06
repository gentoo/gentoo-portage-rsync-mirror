# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/ExtUtils-Command/ExtUtils-Command-1.16.ebuild,v 1.12 2013/01/06 12:05:11 armin76 Exp $

EAPI="2"

MODULE_AUTHOR=RKOBES
inherit perl-module

DESCRIPTION="Utilities to replace common UNIX commands in Makefiles etc."

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc s390 sh sparc x86"
IUSE=""

SRC_TEST=do
PREFER_BUILDPL=no
