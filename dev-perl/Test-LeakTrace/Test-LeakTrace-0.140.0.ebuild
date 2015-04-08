# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-LeakTrace/Test-LeakTrace-0.140.0.ebuild,v 1.4 2014/11/24 16:23:39 jer Exp $

EAPI=5

MODULE_AUTHOR=GFUJI
MODULE_VERSION=0.14
inherit perl-module

DESCRIPTION='Traces memory leaks'

SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~x86"
IUSE=""

SRC_TEST="do"
