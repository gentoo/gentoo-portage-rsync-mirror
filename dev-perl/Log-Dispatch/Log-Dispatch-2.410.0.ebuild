# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Log-Dispatch/Log-Dispatch-2.410.0.ebuild,v 1.1 2015/04/06 19:51:55 dilfridge Exp $

EAPI=5

MY_PN=Log-Dispatch
MODULE_AUTHOR=DROLSKY
MODULE_VERSION=2.41
inherit perl-module

DESCRIPTION="Dispatches messages to multiple Log::Dispatch::* objects"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~ppc-aix"
IUSE=""

RDEPEND="
	dev-perl/Params-Validate
	dev-perl/Class-Load
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31"

SRC_TEST="do"
