# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-LeakTrace/Test-LeakTrace-0.140.0.ebuild,v 1.1 2013/02/10 07:32:41 tove Exp $

EAPI=5

MODULE_AUTHOR=GFUJI
MODULE_VERSION=0.14
inherit perl-module

DESCRIPTION='Traces memory leaks'

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_TEST="do"
