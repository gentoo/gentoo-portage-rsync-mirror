# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/ExtUtils-MakeMaker/ExtUtils-MakeMaker-6.56-r1.ebuild,v 1.7 2012/02/04 16:42:54 armin76 Exp $

EAPI=2

MODULE_AUTHOR=MSCHWERN
inherit perl-module

DESCRIPTION="Create a module Makefile"
HOMEPAGE="http://makemaker.org ${HOMEPAGE}"

SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ~s390 ~sh sparc x86"
IUSE=""

PATCHES=( "${FILESDIR}"/RUNPATH-6.54.patch
	"${FILESDIR}"/6.56-delete_packlist_podlocal.patch )

DEPEND=">=virtual/perl-ExtUtils-Manifest-1.56
	>=virtual/perl-ExtUtils-Command-1.16
	>=virtual/perl-ExtUtils-Install-1.52"
RDEPEND="${DEPEND}
	!!<dev-lang/perl-5.8.8-r7"

SRC_TEST=do
