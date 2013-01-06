# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cgi-Simple/Cgi-Simple-1.113.0.ebuild,v 1.2 2011/09/03 21:04:27 tove Exp $

EAPI=4

MY_PN=CGI-Simple
MODULE_AUTHOR=ANDYA
MODULE_VERSION=1.113
inherit perl-module

DESCRIPTION="A Simple totally OO CGI interface that is CGI.pm compliant"

SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86"
IUSE="test"

RDEPEND=""
DEPEND="virtual/perl-Module-Build
	test? (
		dev-perl/libwww-perl
		dev-perl/IO-stringy
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
