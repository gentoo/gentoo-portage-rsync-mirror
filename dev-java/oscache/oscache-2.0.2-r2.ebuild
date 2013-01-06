# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/oscache/oscache-2.0.2-r2.ebuild,v 1.1 2008/03/22 21:21:19 wltjr Exp $

EAPI=1
JAVA_PKG_IUSE="doc"

inherit java-pkg-2

DESCRIPTION="OSCache is a widely used, high performance J2EE caching framework."
SRC_URI="https://oscache.dev.java.net/files/documents/629/2653/${P}-full.zip"
HOMEPAGE="http://www.opensymphony.com/oscache/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
COMMON_DEP="
		dev-java/commons-collections
		dev-java/commons-logging
		java-virtuals/servlet-api:2.3
		dev-java/sun-jms
		dev-java/jgroups"
RDEPEND=">=virtual/jre-1.3
		${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.3
		${COMMON_DEP}
		app-arch/unzip"
IUSE=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	rm -v *.jar
}

src_compile() {
	local build_dir="${S}"/build
	local classpath="-classpath $(java-pkg_getjars commons-logging,commons-collections,servlet-api-2.3,sun-jms,jgroups):${build_dir}:."
	mkdir ${build_dir}

	echo "Building core..."
	cd "${S}"/src/core/java
	ejavac ${classpath} -nowarn -d ${build_dir} $(find . -name "*.java") || die

	echo "Building cluster support plugin..."
	cd "${S}"/src/plugins/clustersupport/java
	find . -name "*.java" -exec sed -i -e "s/org.javagroups/org.jgroups/g" {} \;
	ejavac ${classpath} -nowarn -d ${build_dir} $(find . -name "*.java") || die

	echo "Building disk persistence plugin..."
	cd "${S}"/src/plugins/diskpersistence/java
	ejavac ${classpath} -nowarn -d ${build_dir} `find . -name "*.java"` || die "compile failed"

	if use doc ; then
		echo "Building documentation..."
		mkdir "${S}"/javadoc
		cd ${build_dir}
		local sourcepath="${S}/src/core/java:${S}/src/plugins/diskpersistence/java:${S}/src/plugins/clustersupport/java"
		javadoc ${classpath} -sourcepath ${sourcepath} -d "${S}"/javadoc \
			$(find com/opensymphony/oscache -type d | tr '/' '.') \
			|| die "failed to create javadoc"
	fi

	cd "${S}"
	jar cf ${PN}.jar -C build . || die "jar failed"
}

src_install() {
	java-pkg_dojar *.jar
	dodoc readme.txt
	use doc && java-pkg_dojavadoc javadoc
}
