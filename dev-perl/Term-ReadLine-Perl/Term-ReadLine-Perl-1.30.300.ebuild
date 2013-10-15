# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ReadLine-Perl/Term-ReadLine-Perl-1.30.300.ebuild,v 1.10 2013/10/15 15:14:30 zlogene Exp $

EAPI=3

MODULE_AUTHOR=ILYAZ
MODULE_SECTION=modules
MODULE_VERSION=1.0303

inherit perl-module

DESCRIPTION="Quick implementation of readline utilities."

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND="dev-perl/TermReadKey"
