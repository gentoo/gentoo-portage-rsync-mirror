# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GraphViz/GraphViz-2.02.ebuild,v 1.6 2008/11/19 13:51:15 tove Exp $

MODULE_AUTHOR=LBROCARD
inherit perl-module

DESCRIPTION="GraphViz - Interface to the GraphViz graphing tool"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""
SRC_TEST="do"

RDEPEND="dev-lang/perl
	media-gfx/graphviz
	dev-perl/IPC-Run"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.28"
