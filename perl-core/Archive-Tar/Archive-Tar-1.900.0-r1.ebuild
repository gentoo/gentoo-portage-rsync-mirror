# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Archive-Tar/Archive-Tar-1.900.0-r1.ebuild,v 1.1 2014/07/24 17:10:31 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=BINGOS
MODULE_VERSION=1.90
inherit perl-module

DESCRIPTION="A Perl module for creation and manipulation of tar files"

SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND=">=virtual/perl-IO-Zlib-1.01
	virtual/perl-IO-Compress
	virtual/perl-Package-Constants"
#	dev-perl/IO-String
RDEPEND="${DEPEND}"

SRC_TEST="do"
