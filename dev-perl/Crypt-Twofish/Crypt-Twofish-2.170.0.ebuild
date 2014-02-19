# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Twofish/Crypt-Twofish-2.170.0.ebuild,v 1.5 2014/02/19 12:47:08 zlogene Exp $

EAPI=4

MODULE_AUTHOR=AMS
MODULE_VERSION=2.17
inherit perl-module

DESCRIPTION="The Twofish Encryption Algorithm"

SLOT="0"
KEYWORDS="amd64 ia64 ~sh sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

SRC_TEST="do"
