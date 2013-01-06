# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-nodeps/ant-nodeps-1.8.1.ebuild,v 1.8 2011/12/31 12:09:48 sera Exp $

# contains the tasks depending on 1.5 java
ANT_TASK_JDKVER=1.5
ANT_TASK_JREVER=1.5

# cannot hurt...
JAVA_PKG_WANT_SOURCE=1.4
JAVA_PKG_WANT_TARGET=1.4

inherit ant-tasks

DESCRIPTION="Apache Ant's optional tasks requiring no external deps"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd ~x64-freebsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

src_unpack() {
	ant-tasks_src_unpack base
	java-pkg_jar-from --build-only ant-core ant-launcher.jar
	java-pkg_filter-compiler jikes
}

src_compile() {
	eant jar-nodeps
}
