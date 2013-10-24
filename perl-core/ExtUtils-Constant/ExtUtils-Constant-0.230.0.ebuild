# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/ExtUtils-Constant/ExtUtils-Constant-0.230.0.ebuild,v 1.2 2013/10/24 14:34:30 jer Exp $

EAPI=4

MODULE_AUTHOR=NWCLARK
MODULE_VERSION="0.23"
inherit perl-module

DESCRIPTION="Generate XS code to import C header constants"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

SRC_TEST="do"
