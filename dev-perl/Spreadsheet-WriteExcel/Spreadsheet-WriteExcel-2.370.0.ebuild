# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Spreadsheet-WriteExcel/Spreadsheet-WriteExcel-2.370.0.ebuild,v 1.7 2012/09/11 15:39:12 armin76 Exp $

EAPI=4

MODULE_AUTHOR=JMCNAMARA
MODULE_VERSION=2.37
inherit perl-module

DESCRIPTION="Write cross-platform Excel binary file."

SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ia64 ppc ~s390 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="virtual/perl-File-Temp
	dev-perl/Parse-RecDescent
	>=dev-perl/OLE-StorageLite-0.19
	dev-perl/IO-stringy"
DEPEND="${RDEPEND}"

SRC_TEST="do"
