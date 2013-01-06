# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-C3-XS/Class-C3-XS-0.130.0.ebuild,v 1.2 2011/09/03 21:05:10 tove Exp $

EAPI=4

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.13
inherit perl-module

DESCRIPTION="XS speedups for Class::C3"

SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86 ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST=do
