# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-RsyncP/File-RsyncP-0.68.ebuild,v 1.11 2011/04/20 13:01:04 jlec Exp $

EAPI=2

MODULE_AUTHOR=CBARRATT
inherit perl-module toolchain-funcs

DESCRIPTION="An rsync perl module"
HOMEPAGE="http://perlrsync.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND="net-misc/rsync"

MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	perl-module_src_prepare
	tc-export CC
}
