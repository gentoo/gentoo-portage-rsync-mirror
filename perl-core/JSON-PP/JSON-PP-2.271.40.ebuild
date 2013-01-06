# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/JSON-PP/JSON-PP-2.271.40.ebuild,v 1.5 2011/03/19 12:35:08 armin76 Exp $

EAPI=3

MODULE_AUTHOR=MAKAMAKA
MODULE_VERSION=2.27104
inherit perl-module

DESCRIPTION="JSON::XS compatible pure-Perl module"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~s390 ~sh ~sparc ~x86 ~ppc-aix ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="!!<dev-perl/JSON-2.50"

SRC_TEST="do"
