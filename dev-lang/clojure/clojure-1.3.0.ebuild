# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/clojure/clojure-1.3.0.ebuild,v 1.3 2011/11/17 18:46:11 phajdan.jr Exp $

EAPI=2
JAVA_PKG_IUSE="source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Clojure is a dynamic programming language that targets the Java Virtual Machine"
HOMEPAGE="http://clojure.org/"
SRC_URI="https://github.com/clojure/clojure/tarball/clojure-1.3.0 -> ${P}.tar.gz"

LICENSE="EPL-1.0"
SLOT="1.3"
KEYWORDS="amd64 x86 ~x86-linux"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

S=${WORKDIR}/clojure-clojure-6375f36

src_test() {
	java-pkg-2_src_test
}

src_install() {
	java-pkg_newjar ${P/_/-}.jar
	java-pkg_dolauncher  ${PN}-${SLOT} --main clojure.main
	dodoc changes.txt readme.txt || die
}
