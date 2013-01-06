# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Parse-CPAN-Meta/Parse-CPAN-Meta-1.420.ebuild,v 1.2 2011/02/20 23:58:27 josejx Exp $

EAPI=3

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=1.4200
inherit perl-module

DESCRIPTION="Parse META.yml and other similar CPAN metadata files"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="
	>=virtual/perl-CPAN-Meta-YAML-0.2
	>=virtual/perl-JSON-PP-2.271.30
	>=virtual/perl-Module-Load-Conditional-0.260
"
DEPEND="${RDEPEND}"

SRC_TEST=do
