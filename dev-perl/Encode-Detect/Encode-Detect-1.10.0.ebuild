# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Encode-Detect/Encode-Detect-1.10.0.ebuild,v 1.2 2011/09/03 21:04:58 tove Exp $

EAPI=4

MODULE_AUTHOR=JGMYERS
MODULE_VERSION=1.01
inherit perl-module

DESCRIPTION="Encode::Detect - An Encode::Encoding subclass that detects the encoding of data"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="virtual/perl-Module-Build
	virtual/perl-ExtUtils-CBuilder"

SRC_TEST=do
