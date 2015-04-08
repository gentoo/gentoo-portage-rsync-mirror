# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Exporter/Exporter-5.680.0.ebuild,v 1.2 2014/01/30 23:13:43 maekke Exp $
EAPI=5
MODULE_AUTHOR=TODDR
MODULE_VERSION=5.68
inherit perl-module

DESCRIPTION='Implements default import method for modules'
LICENSE=" || ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="virtual/perl-ExtUtils-MakeMaker"
RDEPEND=""

SRC_TEST="do"
