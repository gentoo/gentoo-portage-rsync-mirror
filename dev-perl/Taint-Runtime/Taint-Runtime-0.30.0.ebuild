# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Taint-Runtime/Taint-Runtime-0.30.0.ebuild,v 1.3 2013/09/09 09:40:49 pinkbyte Exp $

EAPI=4

MODULE_AUTHOR=RHANDOM
MODULE_VERSION=0.03
inherit perl-module

DESCRIPTION="Runtime enable taint checking"

SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

SRC_TEST=do
