# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-WikiFormat/Text-WikiFormat-0.810.0.ebuild,v 1.1 2015/02/25 10:54:12 monsieurp Exp $

EAPI=5

MODULE_AUTHOR=CYCLES
MODULE_VERSION=0.81
inherit perl-module

DESCRIPTION="Translate Wiki formatted text into other formats"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="dev-perl/URI
	virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.28"

SRC_TEST="do"
