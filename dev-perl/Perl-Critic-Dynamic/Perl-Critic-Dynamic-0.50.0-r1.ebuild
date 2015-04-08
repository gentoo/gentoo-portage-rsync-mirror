# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Perl-Critic-Dynamic/Perl-Critic-Dynamic-0.50.0-r1.ebuild,v 1.3 2014/12/07 19:19:16 zlogene Exp $

EAPI=5

MODULE_AUTHOR=THALJEF
MODULE_VERSION=0.05
inherit perl-module

DESCRIPTION="Base class for dynamic Policies"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="dev-perl/Perl-Critic
	>=dev-perl/Devel-Symdump-2.08
	dev-perl/Readonly"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
