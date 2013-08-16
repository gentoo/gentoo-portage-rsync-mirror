# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Digest/IO-Digest-0.110.0.ebuild,v 1.1 2013/08/16 07:44:32 patrick Exp $

EAPI=4

MODULE_AUTHOR=CLKAO
MODULE_VERSION=0.11
inherit perl-module

DESCRIPTION="IO::Digest - Calculate digests while reading or writing"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND=">=dev-perl/PerlIO-via-dynamic-0.10
	virtual/perl-digest-base"
DEPEND="${RDEPEND}"

SRC_TEST="do"
