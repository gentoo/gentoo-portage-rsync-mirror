# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-CAST5_PP/Crypt-CAST5_PP-1.40.0.ebuild,v 1.2 2011/09/03 21:05:12 tove Exp $

EAPI=4

MODULE_AUTHOR=BOBMATH
MODULE_VERSION=1.04
inherit perl-module

DESCRIPTION="CAST5 block cipher in pure Perl"

SLOT="0"
KEYWORDS="amd64 hppa ia64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

SRC_TEST="do"
