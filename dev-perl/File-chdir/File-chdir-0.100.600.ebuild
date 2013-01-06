# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-chdir/File-chdir-0.100.600.ebuild,v 1.5 2012/04/16 21:26:18 ranger Exp $

EAPI=4

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=0.1006
inherit perl-module

DESCRIPTION="An alternative to File::Spec and CWD"

SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND=">=virtual/perl-File-Spec-3.27"
DEPEND="${RDEPEND}"

SRC_TEST="do"
