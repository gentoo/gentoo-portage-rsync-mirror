# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Simple-DTDReader/XML-Simple-DTDReader-0.40.0.ebuild,v 1.3 2012/10/24 10:55:39 ago Exp $

EAPI=4

MODULE_AUTHOR=ALEXMV
MODULE_VERSION=0.04
inherit perl-module

DESCRIPTION="Simple XML file reading based on their DTDs"

SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=dev-perl/XML-Parser-2.34"
RDEPEND="${DEPEND}"

SRC_TEST=do
