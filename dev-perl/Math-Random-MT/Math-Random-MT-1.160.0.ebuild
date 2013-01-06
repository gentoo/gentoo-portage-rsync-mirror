# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-Random-MT/Math-Random-MT-1.160.0.ebuild,v 1.1 2012/08/06 11:35:36 tove Exp $

EAPI=4

MODULE_AUTHOR=FANGLY
MODULE_VERSION=1.16
inherit perl-module

DESCRIPTION="The Mersenne Twister PRNG"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="
	test? (
		dev-perl/Test-Number-Delta
	)
"

SRC_TEST=do
