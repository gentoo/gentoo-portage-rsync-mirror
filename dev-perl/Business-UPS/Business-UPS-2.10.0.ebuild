# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Business-UPS/Business-UPS-2.10.0.ebuild,v 1.4 2012/03/19 19:26:22 armin76 Exp $

EAPI=4

MODULE_AUTHOR=TODDR
MODULE_VERSION=2.01
inherit perl-module

DESCRIPTION="A UPS Interface Module"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-perl/libwww-perl"
DEPEND="${RDEPEND}"

SRC_TEST="do"
