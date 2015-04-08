# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/javamail/javamail-1.0-r3.ebuild,v 1.1 2015/02/17 22:26:49 fordfrog Exp $

EAPI=4

inherit java-virtuals-2

DESCRIPTION="Virtual for javamail implementations"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="|| (
	dev-java/oracle-javamail:0
	dev-java/sun-javamail:0
	dev-java/gnu-javamail:1
)"

JAVA_VIRTUAL_PROVIDES="oracle-javamail sun-javamail gnu-javamail-1"
