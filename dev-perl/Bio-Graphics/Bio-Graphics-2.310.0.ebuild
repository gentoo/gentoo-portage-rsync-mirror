# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bio-Graphics/Bio-Graphics-2.310.0.ebuild,v 1.1 2012/10/09 18:06:05 tove Exp $

EAPI=4

MODULE_AUTHOR=LDS
MODULE_VERSION=2.31
inherit perl-module

DESCRIPTION="Generate images from Bio::Seq objects for visualization purposes"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/GD
	dev-perl/Statistics-Descriptive"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=no
