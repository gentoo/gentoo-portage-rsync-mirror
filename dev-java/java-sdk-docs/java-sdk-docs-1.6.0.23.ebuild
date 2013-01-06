# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-sdk-docs/java-sdk-docs-1.6.0.23.ebuild,v 1.4 2011/03/23 20:21:21 xarthisius Exp $

ORIG_NAME="jdk-6u23-docs.zip"
SRC_URI="jdk-6u23-docs.zip"
DESCRIPTION="Sun's documentation bundle (including API) for Java SE"
HOMEPAGE="http://java.sun.com/javase/6/docs/"
LICENSE="sun-j2sl-6"
SLOT="1.6.0"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""
DEPEND="app-arch/unzip"
RDEPEND=""
RESTRICT="fetch"

DOWNLOAD_URL="https://cds.sun.com/is-bin/INTERSHOP.enfinity/WFS/CDS-CDS_Developer-Site/en_US/-/USD/ViewProductDetail-Start?ProductRef=jdk-6u23-docs-oth-JPR@CDS-CDS_Developer"
S="${WORKDIR}/docs"

pkg_nofetch() {
	einfo "Please download ${ORIG_NAME} from "
	einfo "${DOWNLOAD_URL}"
	einfo "(select English and agree to the license) and place it in ${DISTDIR}"

# It appears they at least bump the filename nowadays
#	einfo "named as ${SRC_URI}. Because Sun changes the doc zip file"
#	einfo "without changing the filename, we have to resort to renaming to keep"
#	einfo "the md5sum verification working for existing and new downloads."
#	einfo ""

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
