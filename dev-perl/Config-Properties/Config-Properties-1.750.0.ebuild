# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-Properties/Config-Properties-1.750.0.ebuild,v 1.1 2012/07/24 18:36:32 tove Exp $

EAPI="4"

MODULE_AUTHOR=SALVA
MODULE_VERSION=1.75
inherit perl-module

DESCRIPTION="Configuration using Java style properties"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? (
		virtual/perl-File-Temp
		virtual/perl-Test-Simple
	)"

SRC_TEST="do"
