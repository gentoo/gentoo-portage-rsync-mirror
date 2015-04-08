# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/joni/joni-1.1.4.ebuild,v 1.4 2010/10/15 12:37:44 ranger Exp $

EAPI="3"
JAVA_PKG_IUSE="source"
inherit base java-pkg-2 java-ant-2

DESCRIPTION="Java port of the Oniguruma regular expression engine"
HOMEPAGE="http://jruby.codehaus.org/"
SRC_URI="http://github.com/jruby/joni/tarball/${PV} -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

CDEPEND="dev-java/asm:3
	dev-java/jcodings:0"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"

DEPEND="${CDEPEND}
	>=virtual/jdk-1.5"

src_unpack() {
	unpack ${A}
	mv j* "${S}"
}

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_BUILD_TARGET="build"
EANT_GENTOO_CLASSPATH="asm-3 jcodings"

src_install() {
	java-pkg_dojar target/${PN}.jar
	use source && java-pkg_dosrc src/*
}
