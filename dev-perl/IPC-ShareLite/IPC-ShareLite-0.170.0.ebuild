# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IPC-ShareLite/IPC-ShareLite-0.170.0.ebuild,v 1.3 2012/11/23 13:08:50 blueness Exp $

EAPI=4

MODULE_AUTHOR=ANDYA
MODULE_VERSION=0.17
inherit perl-module

DESCRIPTION="IPC::ShareLite module for perl"

SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86 ~x86-solaris"
IUSE="test"

DEPEND="test? ( dev-perl/Test-Pod )"
RDEPEND=""

SRC_TEST=do
