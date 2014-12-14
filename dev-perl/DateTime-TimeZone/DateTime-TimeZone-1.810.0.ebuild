# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-TimeZone/DateTime-TimeZone-1.810.0.ebuild,v 1.3 2014/12/14 14:45:26 zlogene Exp $

EAPI=5

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=1.81
inherit perl-module

DESCRIPTION="Time zone object base class and factory"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~x86"
IUSE="test"

RDEPEND="
	dev-perl/Class-Load
	>=dev-perl/Class-Singleton-1.30.0
	virtual/perl-File-Spec
	dev-perl/List-AllUtils
	dev-perl/Module-Runtime
	>=dev-perl/Params-Validate-0.720.0
	virtual/perl-Scalar-List-Utils
	dev-perl/Try-Tiny
	virtual/perl-parent
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.310.0
	test? (
		virtual/perl-File-Spec
		virtual/perl-File-Temp
		virtual/perl-Storable
		dev-perl/Test-Fatal
		dev-perl/Test-Requires
		>=virtual/perl-Test-Simple-0.920.0
	)
"

SRC_TEST="do"
