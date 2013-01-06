# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Encode-IMAPUTF7/Encode-IMAPUTF7-1.50.0.ebuild,v 1.1 2011/08/31 10:43:12 tove Exp $

EAPI=4

MODULE_AUTHOR=PMAKHOLM
MODULE_VERSION=1.05
inherit perl-module

DESCRIPTION="Modification of UTF-7 encoding for IMAP"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="virtual/perl-Encode"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-NoWarnings )"

SRC_TEST="do"
