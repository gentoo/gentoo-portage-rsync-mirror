# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/IPC-Cmd/IPC-Cmd-0.780.0.ebuild,v 1.13 2013/03/02 16:14:18 ago Exp $

EAPI=4

MODULE_AUTHOR=BINGOS
MODULE_VERSION=0.78
inherit perl-module

DESCRIPTION="Finding and running system commands made easy"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND="virtual/perl-Locale-Maketext-Simple
	virtual/perl-Module-Load-Conditional
	>=virtual/perl-Params-Check-0.26"
RDEPEND="${DEPEND}"

SRC_TEST=do
