# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jna-posix/jna-posix-1.0.1.ebuild,v 1.6 2011/10/28 08:05:55 xarthisius Exp $

EAPI=2
JAVA_PKG_IUSE="source test"
inherit java-pkg-2 java-ant-2

DESCRIPTION="Lightweight cross-platform POSIX emulation layer for Java"
HOMEPAGE="http://kenai.com/projects/jna-posix"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="|| ( CPL-1.0 GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

RDEPEND=">=virtual/jre-1.5
	dev-java/jna:0"

DEPEND=">=virtual/jdk-1.5
	dev-java/jna:0
	test? ( dev-java/ant-junit4 )"

java_prepare() {
	find . -iname '*.jar' -delete
	java-pkg_jar-from --into lib jna
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	use source && java-pkg_dosrc src/*
	dodoc README.txt || die
}

src_test() {
	ANT_TASKS="ant-junit4" eant test -Dlibs.junit_4.classpath="$(java-pkg_getjars --with-dependencies junit-4)"
}
