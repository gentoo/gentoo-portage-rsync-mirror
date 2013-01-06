# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PDF-API2/PDF-API2-2.19.0.ebuild,v 1.2 2012/04/26 11:02:44 ago Exp $

EAPI=3

MODULE_AUTHOR=SSIMMS
MODULE_VERSION=2.019
inherit perl-module

DESCRIPTION="Facilitates the creation and modification of PDF files"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="virtual/perl-IO-Compress
	dev-perl/Font-TTF"
DEPEND="${RDEPEND}"

SRC_TEST="do"
