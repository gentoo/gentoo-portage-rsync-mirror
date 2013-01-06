# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-junit/ant-junit-1.8.1.ebuild,v 1.8 2012/01/01 22:24:13 sera Exp $

EAPI=1

inherit ant-tasks

KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd ~x64-freebsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

# xalan is a runtime dependency of the XalanExecutor task
# which was for some reason moved to ant-junit by upstream
DEPEND="dev-java/junit:0"
RDEPEND="${DEPEND}
	dev-java/xalan:0"

src_compile() {
	eant jar-junit
}

src_install() {
	ant-tasks_src_install
	java-pkg_register-dependency xalan
}
