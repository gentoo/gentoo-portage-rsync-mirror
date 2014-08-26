# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Taint-Runtime/Taint-Runtime-0.30.0-r1.ebuild,v 1.1 2014/08/26 15:43:58 axs Exp $

EAPI=5

MODULE_AUTHOR=RHANDOM
MODULE_VERSION=0.03
inherit perl-module

DESCRIPTION="Runtime enable taint checking"

SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

SRC_TEST=do
