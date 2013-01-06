# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/servlet-api/servlet-api-2.5-r1.ebuild,v 1.8 2012/12/31 21:18:31 grobian Exp $

EAPI=4

inherit java-virtuals-2

DESCRIPTION="Virtual for servlet api"
HOMEPAGE="http://java.sun.com/products/servlet/"
SRC_URI=""

LICENSE="public-domain"
SLOT="${PV}"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x64-macos ~x64-solaris"
IUSE=""

RDEPEND="|| (
		dev-java/tomcat-servlet-api:${SLOT}
		dev-java/resin-servlet-api:${SLOT}
		dev-java/glassfish-servlet-api:${SLOT}
	)"

JAVA_VIRTUAL_PROVIDES="tomcat-servlet-api-${SLOT} resin-servlet-api-${SLOT} glassfish-servlet-api-${SLOT}"
