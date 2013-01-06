# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tie-ToObject/Tie-ToObject-0.30.0.ebuild,v 1.2 2011/09/24 13:24:54 grobian Exp $

EAPI=4

MODULE_AUTHOR=NUFFIN
MODULE_VERSION=0.03
inherit perl-module

DESCRIPTION="Tie to an existing object."

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos"
IUSE="test"

RDEPEND=""
DEPEND="test? ( dev-perl/Test-use-ok )"

SRC_TEST=do
