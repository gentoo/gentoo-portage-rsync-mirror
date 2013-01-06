# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/ranpwd/ranpwd-1.1.ebuild,v 1.7 2010/04/15 21:15:48 idl0r Exp $

EAPI=3

DESCRIPTION="Generates random passwords using the in-kernel cryptographically secure random number generator"
HOMEPAGE="http://www.kernel.org/pub/software/utils/admin/ranpwd/"
SRC_URI="mirror://kernel/software/utils/admin/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	emake INSTALLROOT="${D}" install || die
}
