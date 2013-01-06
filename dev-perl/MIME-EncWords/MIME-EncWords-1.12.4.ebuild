# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-EncWords/MIME-EncWords-1.12.4.ebuild,v 1.3 2012/04/04 07:55:31 jdhore Exp $

EAPI=4

MODULE_AUTHOR=NEZUMI
MODULE_VERSION=1.012.4
inherit perl-module

DESCRIPTION="Deal with RFC 2047 encoded words (improved)"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="virtual/perl-MIME-Base64
	virtual/perl-Encode
	dev-perl/MIME-Charset"
RDEPEND="${DEPEND}"

SRC_TEST="do"
