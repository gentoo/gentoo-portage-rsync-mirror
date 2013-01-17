# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Filesys-SmbClient/Filesys-SmbClient-3.200.0.ebuild,v 1.1 2013/01/17 14:22:46 flameeyes Exp $

EAPI=4

MODULE_AUTHOR="ALIAN"
MODULE_VERSION=3.2
inherit perl-module

DESCRIPTION="Provide Perl API for libsmbclient.so"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-lang/perl
	>=net-fs/samba-3.0.20[smbclient]"
RDEPEND="${DEPEND}"

# tests are not designed to work on a non-developer system.
RESTRICT=test
