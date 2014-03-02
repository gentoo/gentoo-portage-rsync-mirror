# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Log-Log4perl/Log-Log4perl-1.420.0.ebuild,v 1.3 2014/03/02 10:27:09 pacho Exp $

EAPI=4

MODULE_AUTHOR=MSCHILLI
MODULE_VERSION=1.42
inherit perl-module

DESCRIPTION="Log::Log4perl is a Perl port of the widely popular log4j logging package."
HOMEPAGE="http://log4perl.sourceforge.net/"

SLOT="0"
KEYWORDS="amd64 ~arm ~ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="test"

RDEPEND="virtual/perl-Time-HiRes"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple )"

SRC_TEST="do"
