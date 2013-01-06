# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Taint/Test-Taint-1.60.0.ebuild,v 1.1 2012/11/03 18:30:13 tove Exp $

EAPI=4

MODULE_AUTHOR=PETDANCE
MODULE_VERSION=1.06
inherit perl-module

DESCRIPTION="Tools to test taintedness"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND=""
DEPEND="test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
