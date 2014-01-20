# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Time-Local/Time-Local-1.200.0.ebuild,v 1.11 2014/01/20 20:47:08 vapier Exp $

EAPI=3

MODULE_AUTHOR=FLORA
MODULE_VERSION=1.2000
inherit perl-module

DESCRIPTION="Implements timelocal() and timegm()"

SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

SRC_TEST="do"
