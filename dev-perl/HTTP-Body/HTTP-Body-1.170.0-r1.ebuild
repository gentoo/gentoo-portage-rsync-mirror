# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-Body/HTTP-Body-1.170.0-r1.ebuild,v 1.1 2014/08/26 18:59:24 axs Exp $

EAPI=5

MODULE_AUTHOR=GETTY
MODULE_VERSION=1.17
inherit perl-module

DESCRIPTION="HTTP Body Parser"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	virtual/perl-Digest-MD5
	>=virtual/perl-File-Temp-0.14
	dev-perl/libwww-perl
	>=virtual/perl-IO-1.14
"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Deep
		>=virtual/perl-Test-Simple-0.86
	)
"

SRC_TEST=do
