# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Filesys-Notify-Simple/Filesys-Notify-Simple-0.80.0.ebuild,v 1.1 2012/02/02 17:12:06 tove Exp $

EAPI=4

MODULE_AUTHOR=MIYAGAWA
MODULE_VERSION=0.08
inherit perl-module

DESCRIPTION="Simple and dumb file system watcher"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/perl-Filter"
DEPEND="${RDEPEND}"

SRC_TEST=do
