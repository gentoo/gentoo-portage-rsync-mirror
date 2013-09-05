# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Exporter/Exporter-5.680.0.ebuild,v 1.1 2013/09/05 05:37:13 patrick Exp $
EAPI=5
MODULE_AUTHOR=TODDR
MODULE_VERSION=5.68
inherit perl-module

DESCRIPTION='Implements default import method for modules'
LICENSE=" || ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/perl-ExtUtils-MakeMaker"
RDEPEND=""

SRC_TEST="do"
