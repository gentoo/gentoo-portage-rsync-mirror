# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jaffl/jaffl-0.3.ebuild,v 1.4 2011/01/23 16:33:53 xarthisius Exp $

EAPI="2"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="An abstracted interface to invoking native functions from java"
HOMEPAGE="http://kenai.com/projects/jaffl"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

CDEPEND="dev-java/jffi:0.4
	dev-java/jna:0"

RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	${CDEPEND}
	test? (
		dev-java/junit:4
		dev-java/ant-junit4:0
	)"

java_prepare() {
	find . -iname 'junit*.jar' -delete

	epatch "${FILESDIR}/library-path.patch"

	java-pkg_jar-from --into lib jffi-0.4
	java-pkg_jar-from --into lib jna

	sed -i -e '/file.reference.jffi-complete.jar=/d' \
		nbproject/project.properties || die
	sed -i -e '/reference.JNA_Library.jar=/d' \
		nbproject/project.properties || die

	mv nbproject/project.properties nbproject.properties.bak || die
	(
		echo "file.reference.jffi-complete.jar=lib/jffi.jar"
		echo "reference.JNA_Library.jar=lib/jna.jar"
	) > nbproject/project.properties
	cat nbproject.properties.bak >> nbproject/project.properties
}

src_install() {
	java-pkg_dojar "dist/${PN}.jar"
	use doc && java-pkg_dojavadoc dist/javadoc
	use source && java-pkg_dosrc src/*
}

src_test() {
	java-pkg_jar-from --build-only --into lib/junit_4 junit-4 junit.jar junit-4.1.jar
	local paths="$(java-config -di jna,jffi-0.4):${S}/build"
	ANT_TASKS="ant-junit4" eant test \
		-Drun.jvmargs="-Djava.library.path=${paths}"
}
