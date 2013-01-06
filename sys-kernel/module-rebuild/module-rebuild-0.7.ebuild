# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/module-rebuild/module-rebuild-0.7.ebuild,v 1.1 2011/04/04 15:27:27 mpagano Exp $

DESCRIPTION="A utility to rebuild any kernel modules which you have installed"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=""

src_install() {
	newsbin "${FILESDIR}"/${P} ${PN} || die
}
