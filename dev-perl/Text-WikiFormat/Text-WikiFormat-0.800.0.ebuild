# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-WikiFormat/Text-WikiFormat-0.800.0.ebuild,v 1.3 2012/10/14 18:44:59 armin76 Exp $

EAPI=4

MODULE_AUTHOR=CYCLES
MODULE_VERSION=0.80
inherit perl-module

DESCRIPTION="Translate Wiki formatted text into other formats"

SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="dev-perl/URI
	virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.28"

SRC_TEST="do"
