# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/UNIVERSAL-isa/UNIVERSAL-isa-1.201.207.260.ebuild,v 1.3 2012/12/22 17:25:43 ago Exp $

EAPI=4

MODULE_AUTHOR=CHROMATIC
MODULE_VERSION=1.20120726
inherit perl-module

DESCRIPTION="Attempt to recover from people calling UNIVERSAL::isa as a function"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~ppc-aix"
IUSE=""

RDEPEND="virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}"

SRC_TEST=do
