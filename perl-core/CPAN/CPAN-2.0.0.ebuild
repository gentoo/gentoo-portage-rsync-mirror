# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/CPAN/CPAN-2.0.0.ebuild,v 1.4 2014/04/04 01:03:59 mattst88 Exp $

EAPI=5

MODULE_AUTHOR=ANDK
MODULE_VERSION=2.00
inherit perl-module

DESCRIPTION="query, download and build perl modules from CPAN sites"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~x86"
IUSE=""

SRC_TEST="do"
