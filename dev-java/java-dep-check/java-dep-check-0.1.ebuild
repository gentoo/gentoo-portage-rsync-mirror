# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/java-dep-check/java-dep-check-0.1.ebuild,v 1.2 2008/07/19 07:06:09 serkan Exp $

EAPI=1

inherit java-pkg-2

DESCRIPTION="Java Dependency checker"
HOMEPAGE="http://www.gentoo.org/proj/en/java"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

COMMON_DEP="
	dev-java/bcel:0
	dev-java/commons-cli:1"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"

src_compile() {
	ejavac -cp $(java-pkg_getjars bcel,commons-cli-1) -encoding UTF-8 -d . \
		"${FILESDIR}/Main.java"
	jar cf ${PN}.jar javadepchecker/*.class || die "jar failed"
}

src_install() {
	java-pkg_dojar ${PN}.jar
	java-pkg_dolauncher ${PN} --main javadepchecker.Main
}
