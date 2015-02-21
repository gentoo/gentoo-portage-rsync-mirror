# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Spiffy/Spiffy-0.460.0.ebuild,v 1.1 2015/02/21 00:29:38 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=INGY
MODULE_VERSION=0.46
inherit perl-module

DESCRIPTION="Spiffy Perl Interface Framework For You"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND=">=virtual/perl-ExtUtils-MakeMaker-6.300.0"

SRC_TEST="do"
