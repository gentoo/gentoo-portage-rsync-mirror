# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-des-ede3/crypt-des-ede3-0.10.0.ebuild,v 1.2 2011/09/03 21:05:10 tove Exp $

EAPI=4

MY_PN=Crypt-DES_EDE3
MODULE_AUTHOR=BTROTT
MODULE_VERSION=0.01
inherit perl-module

DESCRIPTION="Triple-DES EDE encryption/decryption"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ~ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/Crypt-DES"
DEPEND="${RDEPEND}"

SRC_TEST=do
