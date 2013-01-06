# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Ace/Ace-1.920.0.ebuild,v 1.2 2011/09/03 21:04:29 tove Exp $

EAPI=4

MY_PN=AcePerl
MODULE_AUTHOR=LDS
MODULE_VERSION=1.92
inherit perl-module

DESCRIPTION="Object-Oriented Access to ACEDB Databases"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="virtual/perl-Digest-MD5
	dev-perl/Cache-Cache"
RDEPEND="${DEPEND}"

# online tests
RESTRICT=test
