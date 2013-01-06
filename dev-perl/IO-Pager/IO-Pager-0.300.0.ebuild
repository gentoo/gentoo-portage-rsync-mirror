# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Pager/IO-Pager-0.300.0.ebuild,v 1.4 2012/12/06 18:41:47 ago Exp $

EAPI=4

MODULE_A_EXT=tgz
MODULE_AUTHOR=JPIERCE
MODULE_VERSION=0.30
inherit perl-module

DESCRIPTION="Select a pager, optionally pipe it output if destination is a TTY"

SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

SRC_TEST=do
S=${WORKDIR}/${PN}-0.3

src_prepare() {
	rm t.pl || die
	sed -i '/^t.pl/d' MANIFEST || die
	perl-module_src_prepare
}
