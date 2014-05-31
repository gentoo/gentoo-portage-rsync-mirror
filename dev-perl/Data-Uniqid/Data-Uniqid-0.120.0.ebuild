# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Uniqid/Data-Uniqid-0.120.0.ebuild,v 1.2 2014/05/31 10:20:39 zlogene Exp $

EAPI="4"

MODULE_AUTHOR="MWX"
MODULE_VERSION=0.12
inherit perl-module

DESCRIPTION="Perl extension for simple generating of unique ids"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	virtual/perl-Math-BigInt
	virtual/perl-Time-HiRes
"
DEPEND="${RDEPEND}"

SRC_TEST="do"
