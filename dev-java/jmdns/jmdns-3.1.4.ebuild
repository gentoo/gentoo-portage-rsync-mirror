# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jmdns/jmdns-3.1.4.ebuild,v 1.1 2013/10/08 16:27:31 ercpe Exp $

EAPI="5"

JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="JmDNS is an implementation of multi-cast DNS in Java."
SRC_URI="mirror://sourceforge/${PN}/${PF}.tgz"
HOMEPAGE="http://jmdns.sourceforge.net"

LICENSE="Apache-2.0"
SLOT="3.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

S="${WORKDIR}/${P}"
JAVA_SRC_DIR="src"

src_prepare() {
	rm "${S}"/build.xml
	rm "${S}"/lib/*.jar || die
}
