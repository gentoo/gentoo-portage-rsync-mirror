# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/bcel/bcel-5.2-r1.ebuild,v 1.3 2012/01/01 22:30:21 sera Exp $

EAPI=2

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="The Byte Code Engineering Library: analyze, create, manipulate Java class files"
HOMEPAGE="http://commons.apache.org/bcel/"
SRC_URI="mirror://apache/jakarta/${PN}/source/${P}-src.tar.gz
	findbugs? ( http://dev.gentoo.org/~fordfrog/distfiles/findbugs-${P}_p20070531.patch.bz2 )"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="-findbugs"

CDEPEND="dev-java/ant-junit
	=dev-java/junit-4*"

RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.5
	${CDEPEND}"

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_ANT_TASKS="ant-junit,junit"
ANT_OPTS="-Xmx256m"

java_prepare() {
	if use findbugs; then
		mv build.xml build.xml.bak
		EPATCH_OPTS="-p7" \
			epatch "${WORKDIR}"/findbugs-${P}_p20070531.patch
		rm build.xml && mv build.xml.bak build.xml
	fi
}

src_install() {
	java-pkg_newjar ./target/${P}.jar
	dodoc README.txt || die

	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/*
}
