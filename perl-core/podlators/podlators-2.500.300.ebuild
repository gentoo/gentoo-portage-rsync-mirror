# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/podlators/podlators-2.500.300.ebuild,v 1.1 2013/10/28 05:55:30 patrick Exp $

EAPI=5

MODULE_AUTHOR=RRA
MODULE_VERSION=2.5.3
inherit perl-module

DESCRIPTION="Format POD source into various output formats"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.8.8-r8
	>=virtual/perl-Pod-Simple-3.06"
DEPEND="${RDEPEND}"

SRC_TEST=parallel
