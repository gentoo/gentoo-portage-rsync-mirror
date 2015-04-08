# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Module-Load-Conditional/Module-Load-Conditional-0.580.0.ebuild,v 1.2 2014/01/20 20:58:29 vapier Exp $

EAPI=5

MODULE_AUTHOR=BINGOS
MODULE_VERSION=0.58
inherit perl-module

DESCRIPTION="Looking up module information / loading at runtime"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="
	>=virtual/perl-Module-Load-0.12
	>=virtual/perl-Module-CoreList-0.22
	>=virtual/perl-Module-Metadata-1.0.5
	virtual/perl-Locale-Maketext-Simple
	virtual/perl-Params-Check
	virtual/perl-version
"
DEPEND="${RDEPEND}"

SRC_TEST=do
