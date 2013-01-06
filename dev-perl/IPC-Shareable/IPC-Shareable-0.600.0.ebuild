# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IPC-Shareable/IPC-Shareable-0.600.0.ebuild,v 1.1 2011/08/30 13:16:22 tove Exp $

EAPI=4

MODULE_AUTHOR=BSUGARS
MODULE_VERSION=0.60
inherit perl-module

DESCRIPTION="Tie a variable to shared memory"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

PATCHES=( "${FILESDIR}"/fix_perl_5.10_compat.patch )
SRC_TEST=do
