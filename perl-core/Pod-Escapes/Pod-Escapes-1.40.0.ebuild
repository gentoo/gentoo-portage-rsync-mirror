# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Pod-Escapes/Pod-Escapes-1.40.0.ebuild,v 1.3 2012/04/28 01:44:16 aballier Exp $

EAPI=2

MODULE_AUTHOR=SBURKE
MODULE_VERSION=1.04
inherit perl-module

DESCRIPTION="for resolving Pod E<...> sequences"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

SRC_TEST="do"
