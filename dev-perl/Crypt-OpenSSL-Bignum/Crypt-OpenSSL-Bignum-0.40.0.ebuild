# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-OpenSSL-Bignum/Crypt-OpenSSL-Bignum-0.40.0.ebuild,v 1.3 2011/12/13 09:08:06 naota Exp $

EAPI=4

MODULE_AUTHOR=IROBERTS
MODULE_VERSION=0.04
inherit perl-module

DESCRIPTION="OpenSSL's multiprecision integer arithmetic"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}"

SRC_TEST="do"
