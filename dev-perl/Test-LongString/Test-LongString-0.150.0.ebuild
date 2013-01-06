# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-LongString/Test-LongString-0.150.0.ebuild,v 1.6 2012/11/23 13:13:51 blueness Exp $

EAPI=4

MODULE_AUTHOR=RGARCIA
MODULE_VERSION=0.15
inherit perl-module

DESCRIPTION="A library to test long strings."

SLOT="0"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND=""
DEPEND="test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
