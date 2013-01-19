# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/threads-shared/threads-shared-1.430.0.ebuild,v 1.1 2013/01/19 16:23:48 tove Exp $

EAPI=5

MODULE_AUTHOR=JDHEDDEN
MODULE_VERSION=1.43
inherit perl-module

DESCRIPTION="Extension for sharing data structures between threads"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-lang/perl[ithreads]
	>=virtual/perl-threads-1.71"
DEPEND="${RDEPEND}"

SRC_TEST=do
