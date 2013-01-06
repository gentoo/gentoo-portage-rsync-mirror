# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-SearchPath/File-SearchPath-0.60.0.ebuild,v 1.1 2011/08/30 15:42:08 tove Exp $

EAPI=4

MODULE_AUTHOR=TJENNESS
MODULE_VERSION=0.06
inherit perl-module

DESCRIPTION="Search for a file in an environment variable path"

LICENSE="|| ( GPL-2 GPL-3 )" # GPL-2+
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
