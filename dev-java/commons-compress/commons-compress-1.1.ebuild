# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-compress/commons-compress-1.1.ebuild,v 1.1 2011/07/31 14:21:09 tommy Exp $

EAPI="4"

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Commons Compress defines an API for working with ar, cpio, tar, zip, gzip and bzip2 files."

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
	test? (	dev-java/ant-junit:0 )"

S="${WORKDIR}/${P}-src"

JAVA_ANT_BSFIX_EXTRA_ARGS="--maven-cleaning"
EANT_BUILD_TARGET="compile package"

java_prepare() {
	cp "${FILESDIR}"/build.xml . || die "Failed to copy build.xml"

	# osgi stuff mvn ant:ant doesn't handle
	mkdir -p target/osgi || die "Failed to create target dir"
	cp "${FILESDIR}"/MANIFEST.MF target/osgi/ || die "Failed to copy manifest"

	if ! use test; then
		find -name "*.jar" -delete || die "Failed to remove test resources"
	fi
}

src_test() {
	java-pkg_jarfrom junit
	EANT_TEST_TARGET="compile-tests test"
	java-pkg-2_src_test
}

src_install() {
	java-pkg_newjar target/${P}.jar
	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
