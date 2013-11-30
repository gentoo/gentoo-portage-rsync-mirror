# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ehcache/ehcache-1.2.4.ebuild,v 1.2 2013/11/30 08:19:52 tomwij Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="Ehcache is a pure Java, fully-featured, in-process cache."
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://ehcache.sourceforge.net"

LICENSE="Apache-1.1"
SLOT="1.2"
KEYWORDS="~amd64 ~x86"
IUSE="doc source"

COMMON_DEPEND="
		dev-java/commons-collections
		dev-java/concurrent-util
		dev-java/commons-logging
		~dev-java/servletapi-2.4"
RDEPEND=">=virtual/jre-1.4
		${COMMON_DEPEND}"
DEPEND=">=virtual/jdk-1.4
		${COMMON_DEPEND}
		source? ( app-arch/zip )
		>=dev-java/ant-core-1.5"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mkdir src && cd src
	unzip -qq ../${P}-sources.jar || die
	rm -rf net/sf/ehcache/hibernate
}

src_compile() {
	mkdir "${S}"/classes
	cd "${S}"/src

	ejavac -d "${S}"/classes \
		-classpath 	$(java-pkg_getjars commons-logging,commons-collections,servletapi-2.4) \
		$(find . -name "*.java")

	cd "${S}"/classes
	jar cf "${S}"/${P}.jar * || die "failed to create jar"
}

src_install() {
	java-pkg_newjar "${S}"/${P}.jar
	dodoc *.txt ehcache.xml ehcache.xsd
	use source && java-pkg_dosrc src
	if use doc ; then
		unzip -qq ${P}-javadoc.zip || die
		java-pkg_dohtml -r docs
	fi
}
