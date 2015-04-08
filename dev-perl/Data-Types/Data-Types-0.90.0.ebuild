# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Types/Data-Types-0.90.0.ebuild,v 1.1 2015/01/20 13:21:40 chainsaw Exp $

EAPI=5

MODULE_AUTHOR="DWHEELER"
MODULE_VERSION="0.09"

inherit perl-module

DESCRIPTION="Validate and convert data types."
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
SRC_TEST=do
DEPEND="virtual/perl-Module-Build
	test? ( virtual/perl-Test-Simple )"
