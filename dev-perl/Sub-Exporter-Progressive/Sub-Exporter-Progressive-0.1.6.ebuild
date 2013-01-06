# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sub-Exporter-Progressive/Sub-Exporter-Progressive-0.1.6.ebuild,v 1.3 2012/12/10 19:14:07 ago Exp $

EAPI=4

MODULE_AUTHOR=LEONT
MODULE_VERSION=0.001006
inherit perl-module

DESCRIPTION="Only use Sub::Exporter if you need it"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-solaris"
IUSE=""

RDEPEND="
	dev-perl/Sub-Exporter
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.300.0
"

SRC_TEST=do
