# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ScreenColor/Term-ScreenColor-1.200.0-r1.ebuild,v 1.1 2014/08/26 17:10:18 axs Exp $

EAPI=5

MODULE_AUTHOR=RUITTENB
MODULE_VERSION=1.20
inherit perl-module

DESCRIPTION="A Term::Screen based screen positioning and coloring module"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-perl/Term-Screen-1.30.0"
DEPEND="${RDEPEND}"

# Tests require a real tty device attached to stdin
#SRC_TEST="do"
