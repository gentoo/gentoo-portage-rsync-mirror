# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Eval-LineNumbers/Eval-LineNumbers-0.310.0.ebuild,v 1.1 2011/09/05 19:10:55 robbat2 Exp $

EAPI=4
MODULE_AUTHOR=MUIR
MODULE_SECTION=modules
MODULE_VERSION=0.31

inherit perl-module

DESCRIPTION="Add line numbers to hereis blocks that contain perl source code"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"
