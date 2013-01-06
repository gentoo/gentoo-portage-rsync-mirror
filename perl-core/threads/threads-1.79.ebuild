# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/threads/threads-1.79.ebuild,v 1.1 2010/09/26 07:29:21 tove Exp $

EAPI=3

MODULE_AUTHOR=JDHEDDEN
inherit perl-module

DESCRIPTION="Perl interpreter-based threads"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl[ithreads]"
DEPEND="${RDEPEND}"

SRC_TEST=do
