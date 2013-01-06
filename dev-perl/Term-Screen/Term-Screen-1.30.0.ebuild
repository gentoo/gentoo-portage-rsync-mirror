# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-Screen/Term-Screen-1.30.0.ebuild,v 1.1 2011/11/18 09:01:31 radhermit Exp $

EAPI=4

MODULE_AUTHOR=JSTOWE
MODULE_VERSION=1.03
inherit perl-module

DESCRIPTION="A simple Term::Cap based screen positioning module"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Tests are interactive
#SRC_TEST="do"
