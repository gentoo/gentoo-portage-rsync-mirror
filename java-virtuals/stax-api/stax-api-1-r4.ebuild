# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/stax-api/stax-api-1-r4.ebuild,v 1.3 2012/10/04 17:40:49 sera Exp $

EAPI=1

inherit java-virtuals-2

DESCRIPTION="Virtual for Streaming API for XML (StAX)"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="|| (
			>=virtual/jre-1.6
			dev-java/jsr173
		)"

JAVA_VIRTUAL_PROVIDES="jsr173"
JAVA_VIRTUAL_VM=">=virtual/jre-1.6"
