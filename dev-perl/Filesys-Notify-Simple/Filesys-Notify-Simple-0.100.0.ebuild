# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Filesys-Notify-Simple/Filesys-Notify-Simple-0.100.0.ebuild,v 1.1 2013/02/01 20:29:51 tove Exp $

EAPI=5

MODULE_AUTHOR=MIYAGAWA
MODULE_VERSION=0.10
inherit perl-module

DESCRIPTION="Simple and dumb file system watcher"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="virtual/perl-Filter"
DEPEND="
	test? (
		${RDEPEND}
		dev-perl/Test-SharedFork
	)
"

SRC_TEST=do
