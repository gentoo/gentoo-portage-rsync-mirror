# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Fuse/Fuse-0.150.0.ebuild,v 1.1 2012/04/29 10:47:54 tove Exp $

EAPI=4

MODULE_AUTHOR=DPATES
MODULE_VERSION=0.15
inherit perl-module

DESCRIPTION="Fuse module for perl"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-fs/fuse"
DEPEND="${RDEPEND}"

# Test is whack - ChrisWhite
#SRC_TEST="do"
