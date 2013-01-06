# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/ExtUtils-Command/ExtUtils-Command-1.16.ebuild,v 1.11 2012/08/05 18:18:19 maekke Exp $

EAPI="2"

MODULE_AUTHOR=RKOBES
inherit perl-module

DESCRIPTION="Utilities to replace common UNIX commands in Makefiles etc."

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ~s390 ~sh sparc x86"
IUSE=""

SRC_TEST=do
PREFER_BUILDPL=no
