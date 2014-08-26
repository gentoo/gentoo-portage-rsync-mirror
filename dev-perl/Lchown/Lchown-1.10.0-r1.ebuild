# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lchown/Lchown-1.10.0-r1.ebuild,v 1.1 2014/08/26 18:24:44 axs Exp $

EAPI=5

MODULE_AUTHOR=NCLEATON
MODULE_VERSION=1.01
inherit perl-module

DESCRIPTION="Use the lchown(2) system call from Perl"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=""
DEPEND="
	${RDEPEND}
	virtual/perl-Module-Build"
