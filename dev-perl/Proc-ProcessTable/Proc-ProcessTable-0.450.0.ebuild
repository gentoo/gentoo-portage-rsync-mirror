# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Proc-ProcessTable/Proc-ProcessTable-0.450.0.ebuild,v 1.2 2011/09/03 21:05:08 tove Exp $

EAPI=4

MODULE_AUTHOR=DURIST
MODULE_VERSION=0.45
inherit perl-module

DESCRIPTION="Unix process table information"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND="virtual/perl-Storable"
DEPEND="${RDEPEND}"

SRC_TEST="do"
PATCHES=(
	"${FILESDIR}/amd64_canonicalize_file_name_definition.patch"
	"${FILESDIR}/0.45-pthread.patch"
	"${FILESDIR}/0.45-fix-format-errors.patch"
)
