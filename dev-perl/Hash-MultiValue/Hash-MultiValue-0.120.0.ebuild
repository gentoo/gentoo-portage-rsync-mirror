# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Hash-MultiValue/Hash-MultiValue-0.120.0.ebuild,v 1.1 2012/02/16 15:13:13 tove Exp $

EAPI=4

MODULE_AUTHOR=ARISTOTLE
MODULE_VERSION=0.12
inherit perl-module

DESCRIPTION="Store multiple values per key"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/perl-Filter"
DEPEND="${RDEPEND}"

SRC_TEST=do
