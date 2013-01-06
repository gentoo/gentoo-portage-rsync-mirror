# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/podlators/podlators-2.2.2.ebuild,v 1.2 2009/11/16 13:16:33 tove Exp $

EAPI=2

MODULE_AUTHOR=RRA
inherit perl-module

DESCRIPTION="Format POD source into various output formats"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.8.8-r8
	virtual/perl-Pod-Simple"
DEPEND="${RDEPEND}"

SRC_TEST=do
