# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Find/Module-Find-0.100.0.ebuild,v 1.2 2011/09/03 21:04:28 tove Exp $

EAPI=4

MODULE_AUTHOR=CRENZ
MODULE_VERSION=0.10
inherit perl-module

DESCRIPTION="Find and use installed modules in a (sub)category"

SLOT="0"
KEYWORDS="amd64 x86 ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
