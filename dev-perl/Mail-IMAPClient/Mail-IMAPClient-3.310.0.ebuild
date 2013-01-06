# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-IMAPClient/Mail-IMAPClient-3.310.0.ebuild,v 1.6 2012/08/27 17:53:09 armin76 Exp $

EAPI=4

MODULE_AUTHOR=PLOBBES
MODULE_VERSION=3.31
inherit perl-module

DESCRIPTION="IMAP client module for Perl"

SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ~ppc64 s390 sh sparc x86"
IUSE="test"

RDEPEND=">=dev-perl/Parse-RecDescent-1.94"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"
#		>=virtual/perl-File-Temp-0.18 )"
		# only used in t/basic.t

SRC_TEST="do"
