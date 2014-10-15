# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/File-Temp/File-Temp-0.230.0.ebuild,v 1.1 2014/10/15 21:54:13 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=TJENNESS
MODULE_VERSION=0.23
inherit perl-module

DESCRIPTION="File::Temp can be used to create and open temporary files in a safe way"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

# bug 390719
PATCHES=( "${FILESDIR}/${PN}-0.230.0-symlink-safety.patch" )

SRC_TEST="do"
