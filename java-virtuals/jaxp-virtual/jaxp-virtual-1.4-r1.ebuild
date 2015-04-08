# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/jaxp-virtual/jaxp-virtual-1.4-r1.ebuild,v 1.9 2014/12/02 14:30:46 mrueg Exp $

EAPI=5

inherit java-virtuals-2

DESCRIPTION="Virtual for Java API for XML Processing (JAXP)"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="|| (
			>=virtual/jre-1.6
			>=dev-java/jaxp-1.4-r1:0
		)
		>=dev-java/java-config-2.1.8"

JAVA_VIRTUAL_PROVIDES="jaxp"
JAVA_VIRTUAL_VM=">=virtual/jre-1.6"
