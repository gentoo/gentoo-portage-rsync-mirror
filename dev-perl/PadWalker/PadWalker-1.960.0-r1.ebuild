# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PadWalker/PadWalker-1.960.0-r1.ebuild,v 1.1 2014/08/22 19:46:34 axs Exp $

EAPI=5

MODULE_AUTHOR=ROBIN
MODULE_VERSION=1.96
inherit perl-module

DESCRIPTION="play with other peoples' lexical variables"

SLOT="0"
KEYWORDS="amd64 ~arm ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

SRC_TEST="do"
