# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/CPAN/CPAN-2.0.0.ebuild,v 1.5 2014/04/07 12:46:19 zlogene Exp $

EAPI=5

MODULE_AUTHOR=ANDK
MODULE_VERSION=2.00
inherit perl-module

DESCRIPTION="query, download and build perl modules from CPAN sites"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~x86"
IUSE=""

SRC_TEST="do"
