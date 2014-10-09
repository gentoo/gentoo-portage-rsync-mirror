# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Entities/XML-Entities-1.0.100.ebuild,v 1.2 2014/10/09 20:12:50 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=SIXTEASE
MODULE_VERSION=1.0001
inherit perl-module

DESCRIPTION="Decode strings with XML entities"

LICENSE="|| ( Artistic GPL-1 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="virtual/perl-Carp"

DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( virtual/perl-Test-Simple )"

SRC_TEST="do"

S=${WORKDIR}/${PN}
