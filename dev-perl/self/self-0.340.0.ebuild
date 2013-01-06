# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/self/self-0.340.0.ebuild,v 1.1 2011/08/27 16:47:13 tove Exp $

EAPI=4

MODULE_AUTHOR=GUGOD
MODULE_VERSION=0.34
inherit perl-module

DESCRIPTION="provides '\$self' in OO code."

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-perl/B-Hooks-Parser-0.09
	>=dev-perl/PadWalker-1.9.2
	dev-perl/Sub-Exporter
	>=dev-perl/Devel-Declare-0.005005
	>=dev-perl/B-OPCheck-0.27"
RDEPEND="${DEPEND}"

SRC_TEST=do
