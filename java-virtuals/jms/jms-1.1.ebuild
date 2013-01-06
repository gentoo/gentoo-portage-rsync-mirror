# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/jms/jms-1.1.ebuild,v 1.9 2012/10/04 17:37:10 sera Exp $

EAPI="1"

inherit java-virtuals-2

DESCRIPTION="Virtual for Java Message Service (JMS) API"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="|| (
			dev-java/glassfish-jms-api:0
			dev-java/sun-jms:0
		)
		"

JAVA_VIRTUAL_PROVIDES="glassfish-jms-api sun-jms"
