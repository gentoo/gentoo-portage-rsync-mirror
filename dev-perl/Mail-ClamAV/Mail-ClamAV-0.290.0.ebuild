# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-ClamAV/Mail-ClamAV-0.290.0.ebuild,v 1.2 2011/09/03 21:04:32 tove Exp $

EAPI=4

MODULE_AUTHOR=CONVERTER
MODULE_VERSION=0.29
inherit perl-module

DESCRIPTION="Perl extension for the clamav virus scanner"

SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"
IUSE=""

RDEPEND=">=app-antivirus/clamav-0.95.1
	dev-perl/Inline"
DEPEND="${RDEPEND}"

SRC_TEST=do
MAKEOPTS="${MAKEOPTS} -j1"
