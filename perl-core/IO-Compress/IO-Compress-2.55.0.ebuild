# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/IO-Compress/IO-Compress-2.55.0.ebuild,v 1.2 2014/01/20 20:47:43 vapier Exp $

EAPI=4

MODULE_AUTHOR=PMQS
MODULE_VERSION=2.055
inherit perl-module

DESCRIPTION="allow reading and writing of compressed data"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="virtual/perl-Scalar-List-Utils
	>=virtual/perl-Compress-Raw-Zlib-${PV}
	>=virtual/perl-Compress-Raw-Bzip2-${PV}
	!perl-core/Compress-Zlib
	!perl-core/IO-Compress-Zlib
	!perl-core/IO-Compress-Bzip2
	!perl-core/IO-Compress-Base"
DEPEND="${RDEPEND}"
#	test? ( dev-perl/Test-Pod )"

SRC_TEST=parallel
