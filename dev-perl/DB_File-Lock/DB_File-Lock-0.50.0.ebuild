# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DB_File-Lock/DB_File-Lock-0.50.0.ebuild,v 1.1 2011/08/31 13:29:52 tove Exp $

EAPI=4

MODULE_AUTHOR=DHARRIS
MODULE_VERSION=0.05
inherit perl-module

DESCRIPTION="Locking with flock wrapper for DB_File"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/perl-DB_File"
DEPEND="${RDEPEND}"

SRC_TEST=do
