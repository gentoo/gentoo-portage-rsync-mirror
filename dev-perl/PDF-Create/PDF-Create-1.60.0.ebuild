# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PDF-Create/PDF-Create-1.60.0.ebuild,v 1.2 2011/09/03 21:04:49 tove Exp $

EAPI=4

MODULE_AUTHOR=MARKUSB
MODULE_VERSION=1.06
inherit perl-module

DESCRIPTION="PDF::Create allows you to create PDF documents"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

RDEPEND=""
DEPEND="virtual/perl-Module-Build"

SRC_TEST=do
