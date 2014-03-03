# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-HomeDir/File-HomeDir-1.0.0-r1.ebuild,v 1.4 2014/03/03 17:36:20 zlogene Exp $

EAPI=5

MODULE_AUTHOR=ADAMK
MODULE_VERSION=1.00
inherit perl-module

DESCRIPTION="Get home directory for self or other user"

SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sparc x86 ~ppc-aix ~x86-fbsd ~ppc-macos ~x64-macos ~x86-solaris"
IUSE="+xdg"

RDEPEND="virtual/perl-File-Spec
	>=virtual/perl-File-Temp-0.19
	dev-perl/File-Which
	xdg? ( x11-misc/xdg-user-dirs )"

DEPEND="${RDEPEND}"

SRC_TEST="do"
