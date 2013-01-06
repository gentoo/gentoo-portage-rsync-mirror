# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-Random/Math-Random-0.710.0.ebuild,v 1.2 2011/09/03 21:05:11 tove Exp $

EAPI=4

MODULE_AUTHOR=GROMMEL
MODULE_VERSION=0.71
inherit perl-module

DESCRIPTION="Random Number Generators"

LICENSE="( || ( Artistic GPL-2 ) ) public-domain"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

SRC_TEST="do"
