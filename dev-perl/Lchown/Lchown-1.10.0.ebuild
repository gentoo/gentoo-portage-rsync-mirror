# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lchown/Lchown-1.10.0.ebuild,v 1.1 2011/08/30 11:30:07 tove Exp $

EAPI=4

MODULE_AUTHOR=NCLEATON
MODULE_VERSION=1.01
inherit perl-module

DESCRIPTION="Use the lchown(2) system call from Perl"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="
	${RDEPEND}
	virtual/perl-Module-Build"
