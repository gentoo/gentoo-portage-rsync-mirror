# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Sys-Syslog/Sys-Syslog-0.270.0.ebuild,v 1.2 2011/07/30 12:25:21 tove Exp $

MODULE_VERSION=0.27
MODULE_AUTHOR=SAPER
inherit perl-module

DESCRIPTION="Provides same functionality as BSD syslog"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND="dev-lang/perl"

# Tests disabled - they attempt to verify on the live system
#SRC_TEST="do"
