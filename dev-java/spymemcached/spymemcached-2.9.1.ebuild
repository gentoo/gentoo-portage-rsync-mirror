# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/spymemcached/spymemcached-2.9.1.ebuild,v 1.1 2013/11/30 10:21:21 ercpe Exp $

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-pkg-simple

DESCRIPTION="A simple, asynchronous, single-threaded memcached client written in java"
HOMEPAGE="https://code.google.com/p/spymemcached/"
SRC_URI="https://${PN}.googlecode.com/files/${P}-sources.jar"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="spring"

CDEPEND="dev-java/log4j:0
	dev-java/slf4j-api:0
	spring? ( dev-java/spring-beans:3.2 )"

DEPEND=">=virtual/jdk-1.5
	${CDEPEND}"

RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"

S="${WORKDIR}"

JAVA_GENTOO_CLASSPATH="log4j,slf4j-api"

java_prepare() {
	if use spring; then
		JAVA_GENTOO_CLASSPATH+=",spring-beans-3.2"
	else
		rm net/spy/memcached/spring/MemcachedClientFactoryBean.java || die
	fi
}
