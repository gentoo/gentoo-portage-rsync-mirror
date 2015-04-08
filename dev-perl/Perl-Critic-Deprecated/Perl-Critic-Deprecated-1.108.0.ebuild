# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Perl-Critic-Deprecated/Perl-Critic-Deprecated-1.108.0.ebuild,v 1.3 2014/03/20 09:21:56 zlogene Exp $

EAPI=5

MODULE_AUTHOR=ELLIOTJS
MODULE_VERSION=1.108
inherit perl-module

DESCRIPTION="Perl::Critic policies which have been superseded by others"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-perl/Readonly
	dev-perl/Perl-Critic"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
