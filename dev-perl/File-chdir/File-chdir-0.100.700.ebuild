# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-chdir/File-chdir-0.100.700.ebuild,v 1.1 2012/10/07 16:11:50 tove Exp $

EAPI=4

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=0.1007
inherit perl-module

DESCRIPTION="An alternative to File::Spec and CWD"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND=">=virtual/perl-File-Spec-3.27"
DEPEND="${RDEPEND}"

SRC_TEST="do"
