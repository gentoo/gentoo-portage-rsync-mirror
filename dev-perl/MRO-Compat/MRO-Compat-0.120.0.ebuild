# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MRO-Compat/MRO-Compat-0.120.0.ebuild,v 1.9 2013/03/31 10:39:48 ago Exp $

EAPI=4

MODULE_AUTHOR=BOBTFISH
MODULE_VERSION=0.12
inherit perl-module

DESCRIPTION="Lets you build groups of accessors"

SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 sparc x86 ~ppc-aix ~ppc-macos ~x64-macos ~x86-solaris"
IUSE="test"

RDEPEND="
"
#	>=dev-perl/Class-C3-0.20
#	>=dev-perl/Class-C3-XS-0.08
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST=do
