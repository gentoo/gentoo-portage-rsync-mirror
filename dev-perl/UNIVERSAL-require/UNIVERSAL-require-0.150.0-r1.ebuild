# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/UNIVERSAL-require/UNIVERSAL-require-0.150.0-r1.ebuild,v 1.1 2014/08/22 18:28:32 axs Exp $

EAPI=5

MODULE_AUTHOR=NEILB
MODULE_VERSION=0.15
inherit perl-module

DESCRIPTION="UNIVERSAL::require - require() modules from a variable"

SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc sparc x86 ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

SRC_TEST="do"
