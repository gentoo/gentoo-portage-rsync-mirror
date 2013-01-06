# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ReadPassword/Term-ReadPassword-0.110.0.ebuild,v 1.2 2011/09/03 21:04:43 tove Exp $

EAPI=4

MODULE_AUTHOR=PHOENIX
MODULE_VERSION=0.11
inherit perl-module

DESCRIPTION="Term::ReadPassword - Asking the user for a password"

SLOT="0"
KEYWORDS="amd64 ~ppc64 x86"
IUSE=""

# Tests are interactive
#SRC_TEST="do"
