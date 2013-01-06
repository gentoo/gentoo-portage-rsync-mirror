# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/ExtUtils-Constant/ExtUtils-Constant-0.230.0.ebuild,v 1.1 2012/06/16 20:06:08 tove Exp $

EAPI=4

MODULE_AUTHOR=NWCLARK
MODULE_VERSION="0.23"
inherit perl-module

DESCRIPTION="Generate XS code to import C header constants"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_TEST="do"
