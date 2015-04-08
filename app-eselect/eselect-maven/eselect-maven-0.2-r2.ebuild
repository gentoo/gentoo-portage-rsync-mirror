# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-eselect/eselect-maven/eselect-maven-0.2-r2.ebuild,v 1.1 2015/04/05 20:46:14 monsieurp Exp $

EAPI=5

DESCRIPTION="Manages Maven symlinks"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

RDEPEND=">=app-admin/eselect-1.2.8
	!<dev-java/maven-bin-2.0.10-r1:2.1
	!app-eselect/eselect-java"
PDEPEND="
|| (
	dev-java/maven-bin:3.0
	dev-java/maven-bin:2.2
	dev-java/maven-bin:2.0
)"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${FILESDIR}/maven-${PV}.eselect" maven.eselect \
		|| die "newins failed"
}
