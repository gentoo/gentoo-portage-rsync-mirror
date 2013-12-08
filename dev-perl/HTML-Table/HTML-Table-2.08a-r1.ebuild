# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Table/HTML-Table-2.08a-r1.ebuild,v 1.2 2013/12/08 16:37:08 zlogene Exp $

EAPI=5

MODULE_AUTHOR=AJPEACOCK
inherit perl-module

DESCRIPTION="produces HTML tables"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc ~ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
