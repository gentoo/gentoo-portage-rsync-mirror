# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/ExtUtils-Command/ExtUtils-Command-1.170.0.ebuild,v 1.15 2013/04/16 20:39:49 ago Exp $

EAPI=3

MODULE_AUTHOR=FLORA
MODULE_VERSION=1.17
inherit perl-module

DESCRIPTION="Utilities to replace common UNIX commands in Makefiles etc."

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

SRC_TEST=do
