# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Compress-Bzip2/Compress-Bzip2-2.90.0.ebuild,v 1.3 2012/09/01 11:23:46 grobian Exp $

EAPI=4

MODULE_VERSION=2.09
MODULE_AUTHOR=ARJAY
inherit perl-module

DESCRIPTION="A Bzip2 perl module"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ~mips sparc x86 ~ppc-aix"
IUSE=""

RDEPEND="app-arch/bzip2"
DEPEND="${RDEPEND}"

SRC_TEST="do"
