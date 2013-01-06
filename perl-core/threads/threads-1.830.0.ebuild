# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/threads/threads-1.830.0.ebuild,v 1.1 2011/04/23 06:29:03 tove Exp $

EAPI=4

MODULE_AUTHOR=JDHEDDEN
MODULE_VERSION=1.83
inherit perl-module

DESCRIPTION="Perl interpreter-based threads"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl[ithreads]"
DEPEND="${RDEPEND}"

SRC_TEST=do
