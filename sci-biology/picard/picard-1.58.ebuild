# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/picard/picard-1.58.ebuild,v 1.1 2012/01/04 03:41:51 weaver Exp $

EAPI=4

#ESVN_REPO_URI="https://picard.svn.sourceforge.net/svnroot/picard/trunk"
ESVN_REPO_URI="https://picard.svn.sourceforge.net/svnroot/picard/tags/${PV}"

EANT_BUILD_TARGET="all"
JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_NEEDS_TOOLS="true"
WANT_ANT_TASKS="ant-apache-bcel"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="Java-based command-line utilities that manipulate SAM files"
HOMEPAGE="http://picard.sourceforge.net/"
SRC_URI=""
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""
KEYWORDS="~amd64"

COMMON_DEPS=""
DEPEND=">=virtual/jdk-1.6
	dev-java/ant-apache-bcel:0
	app-arch/zip
	${COMMON_DEPS}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEPS}"

src_install() {
	cd dist
	for i in *-${PV}.jar; do java-pkg_newjar $i ${i/-${PV}/}; rm $i; done
	java-pkg_dojar *.jar
	for i in *.jar; do java-pkg_dolauncher ${i/.jar/} --jar $i; done
}
