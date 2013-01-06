# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Blowfish/Crypt-Blowfish-2.120.0.ebuild,v 1.8 2012/05/06 16:40:55 armin76 Exp $

EAPI=4

MODULE_AUTHOR=DPARIS
MODULE_VERSION=2.12
inherit perl-module

DESCRIPTION="Crypt::Blowfish module for perl"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

SRC_TEST="do"

export OPTIMIZE="${CFLAGS}"
