# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CHI/CHI-0.580.0.ebuild,v 1.1 2013/08/25 07:14:41 patrick Exp $

EAPI="4"

MODULE_AUTHOR=HAARG
MODULE_VERSION=0.58
inherit perl-module

DESCRIPTION="Unified cache handling interface"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RESTRICT="test" # missing some packages for that

RDEPEND="
	dev-perl/Hash-MoreUtils
	>=dev-perl/Carp-Assert-0.200.0
	dev-perl/String-RewritePrefix
	>=dev-perl/Log-Any-0.140.0
	>=dev-perl/List-MoreUtils-0.330.0
	dev-perl/Moo
	dev-perl/Moose
	>=dev-perl/Try-Tiny-0.110.0
	>=dev-perl/Time-Duration-Parse-0.60.0
	>=dev-perl/Time-Duration-1.60.0
	dev-perl/Data-UUID
	dev-perl/Digest-JHash
	dev-perl/TimeDate
	dev-perl/JSON
"

DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Deep
		dev-perl/Test-Exception
		dev-perl/Test-Class
		dev-perl/Test-Warn
		dev-perl/MooX-Types-MooseLike
	)"

SRC_TEST="do"
