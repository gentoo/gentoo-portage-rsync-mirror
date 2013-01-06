# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-javamail/ant-javamail-1.7.1.ebuild,v 1.8 2010/02/21 00:23:23 caster Exp $

EAPI=1

ANT_TASK_DEPNAME="--virtual javamail"

inherit ant-tasks

KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND="java-virtuals/javamail
	dev-java/sun-jaf"
RDEPEND="${DEPEND}"

src_unpack() {
	ant-tasks_src_unpack all
	java-pkg_jar-from sun-jaf
}
