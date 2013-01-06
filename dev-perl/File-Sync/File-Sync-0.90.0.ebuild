# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Sync/File-Sync-0.90.0.ebuild,v 1.2 2011/09/03 21:05:12 tove Exp $

EAPI=4

MODULE_AUTHOR=CEVANS
MODULE_VERSION=0.09
inherit perl-module

DESCRIPTION="Perl access to fsync() and sync() function calls"

SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"
