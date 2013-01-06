# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PPIx-EditorTools/PPIx-EditorTools-0.150.0.ebuild,v 1.1 2011/05/12 16:29:44 tove Exp $

EAPI=4

MODULE_AUTHOR=SZABGAB
MODULE_VERSION=0.15
inherit perl-module

DESCRIPTION="Utility methods and base class for manipulating Perl via PPI"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Class-XSAccessor-1.02
	>=dev-perl/PPI-1.203"
DEPEND="test? (
		${RDEPEND}
		dev-perl/Test-Most
		>=dev-perl/Test-Differences-0.48.01
		dev-perl/Test-NoWarnings
	)"

SRC_TEST=do
