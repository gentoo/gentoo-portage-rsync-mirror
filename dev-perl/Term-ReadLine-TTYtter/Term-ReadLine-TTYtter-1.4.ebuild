# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ReadLine-TTYtter/Term-ReadLine-TTYtter-1.4.ebuild,v 1.1 2013/11/06 17:42:47 hwoarang Exp $

EAPI=5

MODULE_AUTHOR=CKAISER
MODULE_VERSION=1.4

inherit perl-module

DESCRIPTION="Quick implementation of readline utilities for ttytter."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/TermReadKey"

SRC_TEST="do parallel"
