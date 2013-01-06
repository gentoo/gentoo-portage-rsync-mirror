# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-XSBuilder/ExtUtils-XSBuilder-0.280.0.ebuild,v 1.2 2011/09/03 21:05:22 tove Exp $

EAPI=4

MODULE_AUTHOR=GRICHTER
MODULE_VERSION=0.28
inherit perl-module

DESCRIPTION="Modules to parse C header files and create XS glue code."

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="dev-perl/Parse-RecDescent
	dev-perl/Tie-IxHash"
DEPEND="${RDEPEND}"

SRC_TEST="do"
