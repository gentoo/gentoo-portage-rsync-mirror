# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Std-Fast/Class-Std-Fast-0.0.8-r1.ebuild,v 1.1 2014/08/21 19:47:34 axs Exp $

EAPI=5

MODULE_AUTHOR="ACID"
MODULE_VERSION=v${PV}
inherit perl-module

DESCRIPTION="Faster but less secure than Class::Std"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=dev-perl/Class-Std-0.11.0
	virtual/perl-version
	virtual/perl-Data-Dumper
	virtual/perl-Scalar-List-Utils
"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		virtual/perl-Test-Simple
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST="do"
