# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/antlr/antlr-4.4.ebuild,v 1.5 2015/05/18 13:15:42 ago Exp $

EAPI="5"

JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A parser generator for C++, C#, Java, and Python"
HOMEPAGE="http://www.antlr.org/"
SRC_URI="https://github.com/${PN}/${PN}4/archive/${PV}.zip"
LICENSE="BSD"
SLOT="4"
KEYWORDS="amd64 ~arm ~ia64 ~ppc ppc64 ~x86 ~x64-freebsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="gunit"

CDEPEND="
	>=dev-java/stringtemplate-3.2:0
	gunit? ( dev-java/junit:4 )"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.6"

DEPEND="${RDEPEND}
	>=virtual/jdk-1.6"

S="${WORKDIR}/${PN}4-${PV}"

src_compile() {
	eant -f build.xml
}

src_install() {
	# Single jar like upstream
	java-pkg_newjar dist/antlr-4.4-complete.jar antlr.jar
	java-pkg_dolauncher antlr4 --main org.antlr.v4.Tool

	if use gunit; then
		java-pkg_dolauncher gunit --main org.antlr.v4.gunit.Interp
	fi

	if use source; then
		java-pkg_dosrc tool/src/org \
			runtime/Java/src/org
	fi
}

pkg_postinst() {
	elog "This ebuild only supports the Java backend for the time being."
}
