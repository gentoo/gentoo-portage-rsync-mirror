# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Remove/File-Remove-1.520.0.ebuild,v 1.8 2012/08/27 18:21:17 armin76 Exp $

EAPI=4

MODULE_AUTHOR=ADAMK
MODULE_VERSION=${PV%0.0}
inherit perl-module

DESCRIPTION="Remove files and directories"

SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND=">=virtual/perl-File-Spec-0.84"
DEPEND="${RDEPEND}"

SRC_TEST="do"
