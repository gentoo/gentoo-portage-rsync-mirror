# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Dumper-Concise/Data-Dumper-Concise-2.20.0.ebuild,v 1.2 2012/09/01 11:28:52 grobian Exp $

EAPI=4

MODULE_AUTHOR=FREW
MODULE_VERSION=2.020
inherit perl-module

DESCRIPTION="Less indentation and newlines plus sub deparsing"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-aix ~x86-solaris"
IUSE=""

#RDEPEND="dev-perl/Devel-ArgNames"
RDEPEND=""
DEPEND="${RDEPEND}"

SRC_TEST=do
