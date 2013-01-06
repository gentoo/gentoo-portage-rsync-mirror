# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Locate/Module-Locate-1.720.0.ebuild,v 1.1 2012/09/30 07:21:48 tove Exp $

EAPI=4

MODULE_AUTHOR=NEILB
MODULE_VERSION=1.72
inherit perl-module

DESCRIPTION="Locate modules in the same fashion as require and use"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

SRC_TEST="do"
