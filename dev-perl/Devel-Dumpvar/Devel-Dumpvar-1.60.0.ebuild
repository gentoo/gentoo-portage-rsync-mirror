# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Dumpvar/Devel-Dumpvar-1.60.0.ebuild,v 1.1 2011/08/31 12:24:55 tove Exp $

EAPI=4

MODULE_AUTHOR=ADAMK
MODULE_VERSION=1.06
inherit perl-module

DESCRIPTION="Pure-OO reimplementation of dumpvar.pl"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/perl-Scalar-List-Utils-1.18"
DEPEND="${RDEPEND}"

SRC_TEST=do
