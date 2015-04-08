# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jakarta-regexp/jakarta-regexp-1.5.ebuild,v 1.3 2015/03/27 10:25:42 ago Exp $

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="100% Pure Java Regular Expression package"
SRC_URI="http://archive.apache.org/dist/${PN/-//}/${P}.tar.gz"
HOMEPAGE="http://jakarta.apache.org/"

SLOT="${PV}"
IUSE=""
LICENSE="Apache-1.1"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~x86-fbsd ~x64-freebsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

S="${WORKDIR}/${P}"

JAVA_SRC_DIR="src/java"

java_prepare() {
	rm build.xml || die
	find -name "*.jar" -delete || die
}
