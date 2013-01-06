# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Parse-CPAN-Meta/Parse-CPAN-Meta-1.440.400.ebuild,v 1.2 2012/04/28 02:33:03 aballier Exp $

EAPI=4

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=1.4404
inherit perl-module

DESCRIPTION="Parse META.yml and other similar CPAN metadata files"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="
	>=virtual/perl-CPAN-Meta-YAML-0.8.0
	>=virtual/perl-JSON-PP-2.272.0
"
DEPEND="${RDEPEND}"

SRC_TEST=do
