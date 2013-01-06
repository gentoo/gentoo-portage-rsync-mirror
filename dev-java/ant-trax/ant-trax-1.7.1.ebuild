# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-trax/ant-trax-1.7.1.ebuild,v 1.8 2012/01/01 20:54:51 sera Exp $

EAPI=1

# xalan is only a runtime dependency
# not strict but recommended, and some build.xml expect it with xslt task
# for example dev-java/tagsoup
ANT_TASK_DEPNAME=""

inherit ant-tasks

DESCRIPTION="Apache Ant .jar with optional tasks depending on XML transformer (xalan)"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="dev-java/xalan:0"

src_install() {
	ant-tasks_src_install
	java-pkg_register-dependency xalan
}
