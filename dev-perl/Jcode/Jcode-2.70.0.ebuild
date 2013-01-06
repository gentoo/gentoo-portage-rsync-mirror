# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Jcode/Jcode-2.70.0.ebuild,v 1.11 2012/08/08 01:20:58 naota Exp $

EAPI=4

MODULE_AUTHOR=DANKOGAI
MODULE_VERSION=2.07
inherit perl-module

DESCRIPTION="Japanese transcoding module for Perl"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND=">=virtual/perl-MIME-Base64-2.1"
DEPEND="${RDEPEND}"

SRC_TEST="do"
