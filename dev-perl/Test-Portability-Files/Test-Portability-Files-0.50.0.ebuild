# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Portability-Files/Test-Portability-Files-0.50.0.ebuild,v 1.1 2011/08/28 13:34:00 tove Exp $

EAPI=4

MODULE_AUTHOR=SAPER
MODULE_VERSION=0.05
inherit perl-module

DESCRIPTION="Check file names portability"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/perl-File-Spec
	virtual/perl-Test-Simple"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"
