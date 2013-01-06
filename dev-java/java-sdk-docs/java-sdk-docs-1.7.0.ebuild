# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-sdk-docs/java-sdk-docs-1.7.0.ebuild,v 1.1 2011/09/02 22:38:42 caster Exp $

ORIG_NAME="jdk-7-fcs-bin-b147-apidocs-27_jun_2011.zip"
SRC_URI="${ORIG_NAME}"

DESCRIPTION="Oracle's documentation bundle (including API) for Java SE"
HOMEPAGE="http://download.oracle.com/javase/7/docs/"
LICENSE="oracle-java-documentation-7"
SLOT="1.7"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND=""
RESTRICT="fetch"

DOWNLOAD_URL="http://www.oracle.com/technetwork/java/javase/documentation/java-se-7-doc-download-435117.html"
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
