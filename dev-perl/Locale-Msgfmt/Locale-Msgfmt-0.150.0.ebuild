# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Locale-Msgfmt/Locale-Msgfmt-0.150.0.ebuild,v 1.1 2011/08/30 11:19:18 tove Exp $

EAPI=4

MODULE_AUTHOR=AZAWAWI
MODULE_VERSION=0.15
inherit perl-module

DESCRIPTION="Compile .po files to .mo files"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="
	test? ( dev-perl/Test-Pod )"

SRC_TEST=do
