# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_require/pam_require-0.6.ebuild,v 1.4 2008/09/16 15:32:28 trapni Exp $

inherit eutils pam

DESCRIPTION="Allows you to require a special group or user to access a service."
HOMEPAGE="http://www.splitbrain.org/Programming/C/pam_require/"
SRC_URI="http://www.splitbrain.org/Programming/C/pam_require/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/pam"

src_compile() {
	./configure --prefix=/ || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dopammod "${S}/pam_require.so"

	dodoc AUTHORS ChangeLog NEWS README
}
