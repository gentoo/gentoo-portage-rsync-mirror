# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-EncWords/MIME-EncWords-1.12.6.ebuild,v 1.2 2013/01/06 14:04:11 ago Exp $

EAPI=4

MODULE_AUTHOR=NEZUMI
MODULE_VERSION=1.012.6
inherit perl-module

DESCRIPTION="Deal with RFC 2047 encoded words (improved)"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/perl-MIME-Base64
	virtual/perl-Encode
	dev-perl/MIME-Charset"
RDEPEND="${DEPEND}"

SRC_TEST="do"
