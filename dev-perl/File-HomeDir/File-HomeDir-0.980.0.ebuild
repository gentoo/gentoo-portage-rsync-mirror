# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-HomeDir/File-HomeDir-0.980.0.ebuild,v 1.7 2012/03/25 14:42:51 armin76 Exp $

EAPI=4

MODULE_AUTHOR=ADAMK
MODULE_VERSION=0.98
inherit perl-module

DESCRIPTION="Get home directory for self or other user"

SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 sparc x86 ~x86-fbsd ~ppc-macos ~x64-macos ~x86-solaris"
IUSE=""

RDEPEND="virtual/perl-File-Spec
	>=virtual/perl-File-Temp-0.19
	dev-perl/File-Which"
DEPEND="${RDEPEND}"

SRC_TEST="do"
