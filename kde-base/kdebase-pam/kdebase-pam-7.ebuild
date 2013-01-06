# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-pam/kdebase-pam-7.ebuild,v 1.15 2012/11/15 18:08:53 johu Exp $

inherit pam

DESCRIPTION="pam.d files used by several KDE components."
HOMEPAGE="http://www.kde.org"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/pam"
RDEPEND="${DEPEND}"

src_install() {
	newpamd "${FILESDIR}/kde.pam-${PV}" kde
	newpamd "${FILESDIR}/kde-np.pam-6" kde-np
}
