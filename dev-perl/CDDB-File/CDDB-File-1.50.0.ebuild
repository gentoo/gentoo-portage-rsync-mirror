# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CDDB-File/CDDB-File-1.50.0.ebuild,v 1.2 2011/09/03 21:04:52 tove Exp $

EAPI=4

MODULE_AUTHOR=TMTM
MODULE_VERSION=1.05
inherit perl-module

DESCRIPTION="Parse a CDDB/freedb data file"

LICENSE="|| ( GPL-3 GPL-2 )" # GPL-2+
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc x86"
IUSE=""

SRC_TEST="do"
