# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/guacamole/guacamole-0.8.0.ebuild,v 1.1 2013/04/28 11:35:31 nativemad Exp $

EAPI=4

inherit eutils
DESCRIPTION="Guacamole is a html5 vnc client as servlet"
HOMEPAGE="http://guacamole.sourceforge.net/"
#I know its terrible, but with the mirror url it always takes the wrong file with the same name...
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mysql? ( http://sourceforge.net/projects/${PN}/files/current/extensions/${PN}-auth-mysql-0.8.0.tar.gz )"
LICENSE="AGPL-3"

SLOT="0"

KEYWORDS="~x86"

IUSE="vnc rdesktop mysql"

DEPEND="dev-java/maven-bin"

RDEPEND="${DEPEND}
	www-servers/tomcat
	>virtual/jre-1.6
	net-misc/guacd
	vnc? ( net-libs/libguac-client-vnc )
	rdesktop? ( net-libs/libguac-client-rdp )
	mysql? ( virtual/mysql )"

src_compile() {
	mkdir "${HOME}"/.m2
	cat /usr/share/`readlink /usr/bin/mvn | sed 's:mvn:maven-bin:'`/conf/settings.xml | \
	sed -e 's:/path/to/local/repo:'${HOME}/.m2':g' -e 's:<!-- localRepo::' >"${S}"/settings.xml
	mvn -s "${S}"/settings.xml package
}

src_install() {
	if use mysql; then
		echo lib-directory: /var/lib/"${PN}"/classpath >>"${S}"/doc/example/"${PN}".properties
		echo auth-provider: net.sourceforge.guacamole.net.auth.mysql.MySQLAuthenticationProvider >>"${S}"/doc/example/"${PN}".properties
		echo mysql-hostname: localhost >>"${S}"/doc/example/"${PN}".properties
		echo mysql-port: 3306 >>"${S}"/doc/example/"${PN}".properties
		echo mysql-database: guacamole >>"${S}"/doc/example/"${PN}".properties
		echo mysql-username: guacamole >>"${S}"/doc/example/"${PN}".properties
		echo mysql-password: some_password >>"${S}"/doc/example/"${PN}".properties
		sed -e 's:basic-user-mapping:#basic-user-mapping:' -i "${S}"/doc/example/"${PN}".properties
		insinto /var/lib/"${PN}"/classpath
		doins "${WORKDIR}"/"${PN}"-auth-mysql-"${PV}"/lib/*.jar
		insinto /usr/share/"${PN}"/schema
		doins "${WORKDIR}"/"${PN}"-auth-mysql-"${PV}"/schema/*.sql
		elog "Please add a mysql database and a user and load the sql files in /usr/share/guacamole/schema/ into it."
		elog "You will also need to adjust the DB propeties in /etc/guacamole.properties!"
		elog "The default user and it's password is \"guacadmin\"."
		elog "You will also need to download the mysql-connector from here http://dev.mysql.com/downloads/connector/j/"
		elog "and put the contained .jar file into /var/lib/guacamole/classpath!"
		elog "-"
	fi
	sed -e 's:/path/to:/etc/guacamole:g' -i "${S}"/doc/example/"${PN}".properties || die "properties sed failed"
	insinto /etc/"${PN}"
	doins "${S}"/doc/example/guacamole.properties
	doins "${S}"/doc/example/user-mapping.xml
	insinto /var/lib/"${PN}"
	newins "${S}"/target/"${P}".war "${PN}".war
	elog "Please unpack /var/lib/"${PN}"/"${PN}".war in to your servlet container! If it is an update,"
	elog "delete the old content first!"
	elog "Read: if you use the command below, delete everything within /var/lib/guacamole/guacamole first!"
	elog "Please also link /etc/guacamole in to the lib directory of your servlet container."
	elog "like this:"
	elog "cd /var/lib/guacamole && mkdir guacamole && cd guacamole && jar -xvf ../guacamole.war && cd .. && mv guacamole /var/lib/tomcat-7/webapps/"
	elog "ln -sf /etc/guacamole/guacamole.properties /usr/share/tomcat-7/lib/"
	elog "You will also need to define users and connectrions in /etc/guacamole/user-mapping.xml if mysql is not used!"
}
