# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-SQLite/DateTime-Format-SQLite-0.110.0.ebuild,v 1.1 2011/08/31 12:33:10 tove Exp $

EAPI=4

MODULE_AUTHOR=CFAERBER
MODULE_VERSION=0.11
inherit perl-module

DESCRIPTION="Parse and format SQLite dates and times"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE=""

RDEPEND=">=dev-perl/DateTime-0.51
	>=dev-perl/DateTime-Format-Builder-0.79.01"
DEPEND="${RDEPEND}"

SRC_TEST=do
