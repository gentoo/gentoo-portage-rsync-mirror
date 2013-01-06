# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Capture-Tiny/Capture-Tiny-0.170.0.ebuild,v 1.4 2012/04/26 02:05:29 jer Exp $

EAPI=4

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=0.17
inherit perl-module

DESCRIPTION="Capture STDOUT and STDERR from Perl, XS or external programs"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ~ppc ~sparc x86"
IUSE="test"

DEPEND="
	test? (
		dev-perl/Inline
	)
"

SRC_TEST=do
