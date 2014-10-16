# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Event/IO-Event-0.813.0.ebuild,v 1.2 2014/10/16 01:28:07 blueness Exp $

EAPI=5

MODULE_AUTHOR=MUIR
MODULE_VERSION=0.813
MODULE_SECTION=modules
inherit perl-module

DESCRIPTION="Tied Filehandles for Nonblocking IO with Object Callbacks"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="
	dev-perl/AnyEvent
	dev-perl/Event
	dev-perl/List-MoreUtils
	virtual/perl-Time-HiRes
"
DEPEND="${RDEPEND}"
