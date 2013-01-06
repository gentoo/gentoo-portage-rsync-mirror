# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Contextual-Return/Contextual-Return-0.4.7.ebuild,v 1.1 2012/10/07 16:50:44 tove Exp $

EAPI=4

MODULE_AUTHOR=DCONWAY
MODULE_VERSION=0.004007
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
