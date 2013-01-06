# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Portability-Files/Test-Portability-Files-0.60.0.ebuild,v 1.2 2013/01/06 02:55:36 zmedico Exp $

EAPI=4

MODULE_AUTHOR=ABRAXXA
MODULE_VERSION=0.06
inherit perl-module

DESCRIPTION="Check file names portability"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	virtual/perl-File-Spec
	virtual/perl-Test-Simple
"
DEPEND="${RDEPEND}"

SRC_TEST="do"
