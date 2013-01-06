# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Fuse/Fuse-0.140.0.ebuild,v 1.2 2012/04/22 10:27:12 ago Exp $

EAPI=4

MODULE_AUTHOR=DPAVLIN
MODULE_VERSION=0.14
inherit perl-module

DESCRIPTION="Fuse module for perl"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="sys-fs/fuse"
DEPEND="${RDEPEND}"

# Test is whack - ChrisWhite
#SRC_TEST="do"
