# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/migemo-dict/migemo-dict-200309.ebuild,v 1.16 2008/01/17 17:20:22 grobian Exp $

IUSE=""

DESCRIPTION="Dictionary files for the Migemo and C/Migemo"
HOMEPAGE="http://openlab.ring.gr.jp/skk/dic.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
SLOT="0"

DEPEND=""

src_install() {
	insinto /usr/share/migemo
	doins migemo-dict
}
