# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/threads-shared/threads-shared-1.370.0.ebuild,v 1.1 2011/04/23 06:26:01 tove Exp $

EAPI=4

MODULE_AUTHOR=JDHEDDEN
MODULE_VERSION=1.37
inherit perl-module

DESCRIPTION="Extension for sharing data structures between threads"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl[ithreads]
	>=virtual/perl-threads-1.71"
DEPEND="${RDEPEND}"

SRC_TEST=do
