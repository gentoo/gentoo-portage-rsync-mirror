# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Filesys-SmbClient/Filesys-SmbClient-3.100.0.ebuild,v 1.1 2012/11/26 02:15:55 flameeyes Exp $

EAPI=4

MODULE_AUTHOR="ALIAN"
MODULE_VERSION=3.1
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
