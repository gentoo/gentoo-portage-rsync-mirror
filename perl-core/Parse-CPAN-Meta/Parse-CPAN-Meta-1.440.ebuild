# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Parse-CPAN-Meta/Parse-CPAN-Meta-1.440.ebuild,v 1.3 2011/05/02 19:41:01 grobian Exp $

EAPI=3

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=1.4400
inherit perl-module

DESCRIPTION="Parse META.yml and other similar CPAN metadata files"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x64-freebsd"
IUSE=""

RDEPEND="
	>=virtual/perl-CPAN-Meta-YAML-0.2
	>=virtual/perl-JSON-PP-2.271.30
	>=virtual/perl-Module-Load-Conditional-0.260
"
DEPEND="${RDEPEND}"

SRC_TEST=do
