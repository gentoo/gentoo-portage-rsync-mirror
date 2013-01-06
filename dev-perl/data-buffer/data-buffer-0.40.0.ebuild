# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/data-buffer/data-buffer-0.40.0.ebuild,v 1.2 2011/09/03 21:04:30 tove Exp $

EAPI=4

MY_PN=Data-Buffer
MODULE_AUTHOR=BTROTT
MODULE_VERSION=0.04
inherit perl-module

DESCRIPTION="Read/write buffer class"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

SRC_TEST=do
