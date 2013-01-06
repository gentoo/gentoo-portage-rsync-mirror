# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Aspell/Text-Aspell-0.90.0.ebuild,v 1.2 2011/09/03 21:05:25 tove Exp $

EAPI=4

MODULE_AUTHOR=HANK
MODULE_VERSION=0.09
inherit perl-module

DESCRIPTION="Perl interface to the GNU Aspell Library"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

# Disabling tests for now - see bug #147897 --ian
#SRC_TEST="do"

RDEPEND="app-text/aspell"
DEPEND="${RDEPEND}"
