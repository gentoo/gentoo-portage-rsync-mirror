# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Parse-CPAN-Meta/Parse-CPAN-Meta-1.440.100.ebuild,v 1.16 2012/05/15 19:16:18 halcy0n Exp $

EAPI=3

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=1.4401
inherit perl-module

DESCRIPTION="Parse META.yml and other similar CPAN metadata files"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="
	>=virtual/perl-CPAN-Meta-YAML-0.2
	>=virtual/perl-JSON-PP-2.271.30
"
DEPEND="${RDEPEND}"

SRC_TEST=do
