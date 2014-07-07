# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-StackTrace-AsHTML/Devel-StackTrace-AsHTML-0.140.0.ebuild,v 1.2 2014/07/07 18:49:13 dilfridge Exp $

EAPI=4

MODULE_AUTHOR=MIYAGAWA
MODULE_VERSION=0.14
inherit perl-module

DESCRIPTION="Displays stack trace in HTML"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-perl/Devel-StackTrace
	dev-perl/Filter
"
DEPEND="${RDEPEND}"

SRC_TEST=do
