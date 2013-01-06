# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Digest-SHA/Digest-SHA-5.48.ebuild,v 1.5 2010/12/07 04:27:26 mattst88 Exp $

MODULE_AUTHOR=MSHELOR
inherit perl-module

DESCRIPTION="Perl extension for SHA-1/224/256/384/512"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
