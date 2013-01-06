# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Feed-Find/Feed-Find-0.70.0.ebuild,v 1.1 2011/08/31 10:12:30 tove Exp $

EAPI=4

MODULE_AUTHOR=BTROTT
MODULE_VERSION=0.07
inherit perl-module

DESCRIPTION="Syndication feed auto-discovery"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-perl/Class-ErrorHandler
	dev-perl/HTML-Parser
	dev-perl/libwww-perl
	dev-perl/URI
"
DEPEND="${RDEPEND}"

SRC_TEST=online
