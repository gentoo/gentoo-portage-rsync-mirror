# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Adapter/Class-Adapter-1.80.0.ebuild,v 1.1 2011/03/24 07:05:09 tove Exp $

EAPI=3

MODULE_AUTHOR=ADAMK
MODULE_VERSION=1.08
inherit perl-module

DESCRIPTION='Implementation of the "Adapter" Design Pattern'

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=virtual/perl-Scalar-List-Utils-1.10"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple )"

SRC_TEST=do
