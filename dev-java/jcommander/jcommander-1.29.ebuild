# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jcommander/jcommander-1.29.ebuild,v 1.2 2013/11/25 18:46:54 ercpe Exp $

EAPI=4

inherit eutils java-pkg-2 java-pkg-simple

GITHUB_USER="cbeust"

DESCRIPTION="Command line parsing framework for Java"
HOMEPAGE="https://github.com/cbeust/jcommander"
SRC_URI="https://github.com/${GITHUB_USER}/${PN}/tarball/${P} -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# test? ( dev-java/testng )
DEPEND="${CDEPEND}
	>=virtual/jdk-1.6"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.6"

JAVA_SRC_DIR="src/main"

S="${WORKDIR}"/${P}

# until testng is in main tree
RESTRICT=test

src_unpack() {
	unpack ${A}
	mv ${GITHUB_USER}-${PN}-* ${P} || die
	rm "${P}"/pom.xml || die
}

src_test() {
	JAVA_SRC_DIR="src/test" \
		JAVA_CLASSPATH_EXTRA="${PN}.jar" \
		PN="${PN}-test" \
		java-pkg-simple_src_compile
}

src_install() {
	java-pkg-simple_src_install
	dodoc README.markdown CHANGELOG
}
