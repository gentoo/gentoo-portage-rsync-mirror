# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Cycle/Devel-Cycle-1.110.0.ebuild,v 1.5 2012/03/24 19:55:36 armin76 Exp $

EAPI=4

MODULE_AUTHOR=LDS
MODULE_VERSION=1.11
inherit perl-module

DESCRIPTION="Find memory cycles in objects"

SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

SRC_TEST="do"
