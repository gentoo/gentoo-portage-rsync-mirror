# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/threads-shared/threads-shared-1.32.ebuild,v 1.1 2010/02/15 19:41:27 tove Exp $

EAPI=2

MODULE_AUTHOR=JDHEDDEN
inherit perl-module

DESCRIPTION="Extension for sharing data structures between threads"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl[ithreads]
	>=virtual/perl-threads-1.71"
DEPEND="${RDEPEND}"

SRC_TEST=do
