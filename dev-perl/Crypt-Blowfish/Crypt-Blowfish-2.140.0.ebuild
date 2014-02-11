# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Blowfish/Crypt-Blowfish-2.140.0.ebuild,v 1.3 2014/02/11 18:50:36 jer Exp $

EAPI=4

MODULE_AUTHOR=DPARIS
MODULE_VERSION=2.14
inherit perl-module

DESCRIPTION="Crypt::Blowfish module for perl"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

SRC_TEST="do"

export OPTIMIZE="${CFLAGS}"
