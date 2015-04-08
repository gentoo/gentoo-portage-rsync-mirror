# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jboss-logging/jboss-logging-3.1.3.ebuild,v 1.1 2013/09/26 17:39:00 ercpe Exp $

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="JBoss logging framework"
HOMEPAGE="http://www.jboss.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.GA.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-java/jboss-logmanager:0
	dev-java/slf4j-api:0
	dev-java/log4j:0"
RDEPEND=">=virtual/jre-1.5
		${CDEPEND}"
DEPEND=">=virtual/jdk-1.5
		${CDEPEND}"

S="${WORKDIR}/${P}.GA/"

JAVA_SRC_DIR="src/main/java"
JAVA_GENTOO_CLASSPATH="jboss-logmanager,slf4j-api,log4j"

java_prepare() {
	rm pom.xml || die
}
