# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/osgi-enterprise-api/osgi-enterprise-api-5.0.0.ebuild,v 1.1 2013/07/03 21:22:46 tomwij Exp $

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="OSGi Enterprise Release 5 Companion Code"
SRC_URI="http://www.osgi.org/download/r5/osgi.enterprise-${PV}.jar"
HOMEPAGE="http://www.osgi.org/Main/HomePage"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

CDEPEND="dev-java/glassfish-persistence:0
	dev-java/osgi-core-api:0
	java-virtuals/servlet-api:2.5"

RDEPEND="${CDEPEND}
	>=virtual/jre-1.5"

DEPEND="${CDEPEND}
	>=virtual/jdk-1.5
	app-arch/unzip"

JAVA_SRC_DIR="OSGI-OPT/src"

JAVA_GENTOO_CLASSPATH="glassfish-persistence,osgi-core-api,servlet-api-2.5"

java_prepare() {
	rm -r org || die
}
