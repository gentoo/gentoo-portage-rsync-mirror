# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Event/Event-1.200.0.ebuild,v 1.1 2011/08/05 18:21:46 tove Exp $

EAPI=4

MODULE_AUTHOR=JPRIT
MODULE_VERSION=1.20
inherit perl-module

DESCRIPTION="fast, generic event loop"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-solaris"
IUSE=""

SRC_TEST="do"

mydoc="ANNOUNCE INSTALL TODO Tutorial.pdf"
