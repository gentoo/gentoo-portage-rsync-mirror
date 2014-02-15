# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Capture-Tiny/Capture-Tiny-0.240.0.ebuild,v 1.9 2014/02/15 16:13:43 zlogene Exp $

EAPI=5

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=0.24
inherit perl-module

DESCRIPTION="Capture STDOUT and STDERR from Perl, XS or external programs"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="test"

DEPEND="
	test? (
		dev-perl/Inline
	)
"

SRC_TEST=do
