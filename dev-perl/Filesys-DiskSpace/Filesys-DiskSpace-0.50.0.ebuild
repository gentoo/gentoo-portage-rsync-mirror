# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Filesys-DiskSpace/Filesys-DiskSpace-0.50.0.ebuild,v 1.2 2011/09/03 21:05:33 tove Exp $

EAPI=4

MODULE_AUTHOR=FTASSIN
MODULE_VERSION=0.05
inherit perl-module

DESCRIPTION="Perl df"

SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

#Disabled - assumes you have ext2 mounts actively mounted!?!
#SRC_TEST="do"
