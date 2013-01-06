# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/podlators/podlators-2.4.0.ebuild,v 1.1 2011/01/27 02:49:00 robbat2 Exp $

EAPI=2

MODULE_AUTHOR=RRA
inherit perl-module

DESCRIPTION="Format POD source into various output formats"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.8.8-r8
	>=virtual/perl-Pod-Simple-3.06"
DEPEND="${RDEPEND}"

SRC_TEST=do
