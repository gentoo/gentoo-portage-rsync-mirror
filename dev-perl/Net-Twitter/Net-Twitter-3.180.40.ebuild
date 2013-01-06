# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Twitter/Net-Twitter-3.180.40.ebuild,v 1.1 2012/11/04 13:01:46 tove Exp $

EAPI=4

MODULE_AUTHOR=MMIMS
MODULE_VERSION=3.18004
inherit perl-module

DESCRIPTION="A perl interface to the Twitter API"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos"
IUSE=""

RDEPEND="
	>=dev-perl/Moose-0.94
	dev-perl/Crypt-SSLeay
	dev-perl/Data-Visitor
	>=dev-perl/DateTime-0.51
	dev-perl/DateTime-Format-Strptime
	>=dev-perl/Devel-StackTrace-1.21
	dev-perl/Digest-HMAC
	virtual/perl-Digest-SHA
	virtual/perl-File-Spec
	dev-perl/HTML-Parser
	dev-perl/libwww-perl
	dev-perl/JSON
	virtual/perl-Scalar-List-Utils
	>=dev-perl/Try-Tiny-0.03
	dev-perl/MooseX-Aliases
	dev-perl/MooseX-Role-Parameterized
	>=dev-perl/Net-OAuth-0.25
	dev-perl/namespace-autoclean
	>=dev-perl/URI-1.40
"
DEPEND="${RDEPEND}"

# online test
SRC_TEST=skip
