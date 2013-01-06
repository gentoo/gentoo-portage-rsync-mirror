# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Perl-Critic-Dynamic/Perl-Critic-Dynamic-0.50.0.ebuild,v 1.2 2012/12/22 18:26:47 ago Exp $

EAPI=4

MODULE_AUTHOR=THALJEF
MODULE_VERSION=0.05
inherit perl-module

DESCRIPTION="Base class for dynamic Policies"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-perl/Perl-Critic
	>=dev-perl/Devel-Symdump-2.08
	dev-perl/Readonly"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
