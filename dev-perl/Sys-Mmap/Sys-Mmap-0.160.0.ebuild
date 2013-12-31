# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sys-Mmap/Sys-Mmap-0.160.0.ebuild,v 1.1 2013/12/25 18:15:16 dilfridge Exp $

EAPI=5

MODULE_AUTHOR="TODDR"
MODULE_VERSION="0.16"

inherit perl-module

DESCRIPTION="Uses mmap to map in a file as a Perl variable"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-lang/perl"
