# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Contextual-Return/Contextual-Return-0.4.5.ebuild,v 1.2 2012/09/01 11:24:53 grobian Exp $

EAPI=4

MODULE_AUTHOR=DCONWAY
MODULE_VERSION=0.004005
inherit perl-module

DESCRIPTION="Create context-sensitive return values"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-aix"
IUSE=""

RDEPEND="
	dev-perl/Want
	virtual/perl-version
"
DEPEND="${RDEPEND}
"

SRC_TEST=do
