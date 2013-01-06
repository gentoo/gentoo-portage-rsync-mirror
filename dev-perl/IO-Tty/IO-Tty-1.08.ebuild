# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Tty/IO-Tty-1.08.ebuild,v 1.6 2010/06/27 19:12:15 nixnut Exp $

MODULE_AUTHOR=RGIERSIG
inherit perl-module

DESCRIPTION="IO::Tty and IO::Pty modules for Perl"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ~ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
