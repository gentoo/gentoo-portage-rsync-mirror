# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/UUID-Tiny/UUID-Tiny-1.30.0.ebuild,v 1.1 2013/01/11 10:43:02 dev-zero Exp $

EAPI=4

MODULE_AUTHOR=CAUGUSTIN
MODULE_VERSION=1.03
inherit perl-module

DESCRIPTION="Pure Perl UUID Support With Functional Interface"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/perl-Digest-SHA
	virtual/perl-Digest-MD5
	virtual/perl-MIME-Base64
	virtual/perl-Time-HiRes"
RDEPEND="${RDEPEND}"

SRC_TEST="do"
