# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Any-Moose/Any-Moose-0.200.0.ebuild,v 1.1 2012/12/31 18:53:29 tove Exp $

EAPI=5

MODULE_AUTHOR=SARTAK
MODULE_VERSION=0.20
inherit perl-module

DESCRIPTION="Use Moose or Mouse modules"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86 ~ppc-macos"
IUSE=""

RDEPEND="|| ( >=dev-perl/Mouse-0.40 dev-perl/Moose )
	virtual/perl-version"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31"

SRC_TEST=do
