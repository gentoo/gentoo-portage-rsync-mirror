# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Utilities/Data-Utilities-0.40.0.ebuild,v 1.1 2011/08/31 12:53:51 tove Exp $

EAPI=4

MODULE_AUTHOR=CORNELIS
MODULE_VERSION=0.04
inherit perl-module

DESCRIPTION="Merge nested Perl data structures"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/Clone"
RDEPEND="${DEPEND}"

SRC_TEST=do
PREFER_BUILDPL=no
