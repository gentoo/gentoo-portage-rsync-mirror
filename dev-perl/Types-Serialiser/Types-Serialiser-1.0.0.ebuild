# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Types-Serialiser/Types-Serialiser-1.0.0.ebuild,v 1.2 2014/11/11 20:49:29 maekke Exp $

EAPI=5

MODULE_AUTHOR=MLEHMANN
MODULE_VERSION=1.0
inherit perl-module

DESCRIPTION="simple data types for common serialisation formats"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="
	dev-perl/common-sense
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"
