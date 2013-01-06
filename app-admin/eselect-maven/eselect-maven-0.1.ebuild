# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-maven/eselect-maven-0.1.ebuild,v 1.6 2010/01/01 19:21:01 fauli Exp $

EAPI=1

DESCRIPTION="Manages Maven symlinks"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

RDEPEND=">=app-admin/eselect-1.0.10
	!<dev-java/maven-bin-2.0.10-r1:2.1"
PDEPEND="
|| (
	dev-java/maven-bin:2.2
	dev-java/maven-bin:2.1
	dev-java/maven-bin:2.0
)"

src_install() {
	insinto /usr/share/eselect/modules
	doins "${FILESDIR}/maven.eselect" || die "doins failed"
}
