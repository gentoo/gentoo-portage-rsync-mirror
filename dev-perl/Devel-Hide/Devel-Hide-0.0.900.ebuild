# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Hide/Devel-Hide-0.0.900.ebuild,v 1.2 2013/04/16 17:19:54 vincent Exp $

EAPI=5

MODULE_AUTHOR=FERREIRA
MODULE_VERSION=0.0009
inherit perl-module

DESCRIPTION="Forces the unavailability of specified Perl modules (for testing)"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

DEPEND="
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST=do
