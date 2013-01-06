# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Module-CoreList/Module-CoreList-2.440.ebuild,v 1.3 2011/01/29 18:06:49 armin76 Exp $

EAPI=3

MODULE_AUTHOR=BINGOS
MODULE_VERSION=2.44
inherit perl-module

DESCRIPTION="what modules shipped with versions of perl"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

#RDEPEND=""
#DEPEND="test? ( dev-perl/Test-Pod )"

SRC_TEST=do
