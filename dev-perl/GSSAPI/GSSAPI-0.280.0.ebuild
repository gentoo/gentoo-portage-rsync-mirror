# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GSSAPI/GSSAPI-0.280.0.ebuild,v 1.2 2011/09/03 21:05:18 tove Exp $

EAPI=4

MODULE_AUTHOR=AGROLMS
MODULE_VERSION=0.28
inherit perl-module

DESCRIPTION="GSSAPI - Perl extension providing access to the GSSAPIv2 library"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE="test"

RDEPEND="virtual/krb5"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple )"

SRC_TEST="do"
