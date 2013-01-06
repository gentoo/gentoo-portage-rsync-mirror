# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Stat-Bits/File-Stat-Bits-1.10.0.ebuild,v 1.1 2011/11/18 08:51:13 radhermit Exp $

EAPI=4

MODULE_AUTHOR=FEDOROV
MODULE_VERSION=1.01
inherit perl-module

DESCRIPTION="File stat bit mask constants"

LICENSE="|| ( GPL-2 GPL-3 )" # GPL-2+
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_TEST="do"
