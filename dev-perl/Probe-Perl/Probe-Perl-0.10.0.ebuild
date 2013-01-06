# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Probe-Perl/Probe-Perl-0.10.0.ebuild,v 1.5 2012/05/12 03:06:51 aballier Exp $

EAPI=4

MODULE_AUTHOR=KWILLIAMS
MODULE_VERSION=0.01
inherit perl-module

DESCRIPTION="Information about the currently running perl"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
