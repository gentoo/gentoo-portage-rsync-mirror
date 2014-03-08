# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SVN-Simple/SVN-Simple-0.280.0.ebuild,v 1.6 2014/03/08 08:20:29 zlogene Exp $

EAPI=4

MODULE_AUTHOR=CLKAO
MODULE_VERSION=0.28
inherit perl-module

DESCRIPTION="SVN::Simple::Edit - Simple interface to SVN::Delta::Editor"

SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=">=dev-vcs/subversion-0.31[perl]"
DEPEND="${RDEPEND}"
