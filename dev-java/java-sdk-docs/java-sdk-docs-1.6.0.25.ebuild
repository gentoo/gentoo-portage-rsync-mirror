# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-sdk-docs/java-sdk-docs-1.6.0.25.ebuild,v 1.4 2012/03/06 21:10:32 ranger Exp $

ORIG_NAME="jdk-6u25-fcs-bin-b04-apidocs-04_Apr_2011.zip"
SRC_URI="jdk-6u25-fcs-bin-b04-apidocs-04_Apr_2011.zip"
DESCRIPTION="Sun's documentation bundle (including API) for Java SE"
HOMEPAGE="http://download.oracle.com/javase/6/docs/index.html"
LICENSE="oracle-java-documentation"
SLOT="1.6.0"
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND=""
RESTRICT="fetch"

DOWNLOAD_URL="http://www.oracle.com/technetwork/java/javase/downloads/jdk-6u25-doc-download-355137.html"
S="${WORKDIR}/docs"

pkg_nofetch() {
	einfo "Please download ${ORIG_NAME} from "
	einfo "${DOWNLOAD_URL}"
	einfo "(agree to the license) and place it in ${DISTDIR}"

	einfo "If you find the file on the download page replaced with a higher"
	einfo "version, please report to the bug 67266 (link below)."
	einfo "If emerge fails because of a checksum error it is possible that"
	einfo "the upstream release changed without renaming. Try downloading the file"
	einfo "again (or a newer revision if available). Otherwise report this to"
	einfo "http://bugs.gentoo.org/67266 and we will make a new revision."
}

src_install(){
	insinto /usr/share/doc/${P}/html
	doins index.html

	for i in *; do
		[[ -d $i ]] && doins -r $i
	done
}
