# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-idea/crypt-idea-1.100.0.ebuild,v 1.1 2013/09/05 22:57:51 zlogene Exp $

EAPI=5

MY_PN=Crypt-IDEA
MODULE_AUTHOR=DPARIS
MODULE_VERSION=1.10
inherit perl-module

DESCRIPTION="Parse and save PGP packet streams"

LICENSE="DES"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

SRC_TEST="do"
