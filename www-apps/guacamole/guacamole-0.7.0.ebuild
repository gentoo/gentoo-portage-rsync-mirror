# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/guacamole/guacamole-0.7.0.ebuild,v 1.2 2012/12/05 21:13:04 nativemad Exp $

EAPI=4

inherit eutils
DESCRIPTION="Guacamole is a html5 vnc client as servlet"
HOMEPAGE="http://guacamole.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="AGPL-3"

SLOT="0"

KEYWORDS="~x86"

IUSE="vnc rdesktop"

DEPEND="dev-java/maven-bin"

RDEPEND="${DEPEND}
	www-servers/tomcat
	>virtual/jre-1.6
	net-misc/guacd
	vnc? ( net-libs/libguac-client-vnc )
	rdesktop? ( net-libs/libguac-client-rdp )"

src_compile() {
	mkdir "${HOME}"/.m2
	cat /usr/share/maven-bin-2.2/conf/settings.xml | sed -e 's:<!-- localRepo:localRepo:g' \
	-e 's:/path/to/local/repo:'${HOME}/.m2':g' >"${S}"/settings.xml
	mvn -s "${S}"/settings.xml package
}

src_install() {
	sed -e 's:/path/to:/etc/guacamole:g' -i "${S}"/doc/example/guacamole.properties || die "properties sed failed"
	insinto /etc/"${PN}"
	doins "${S}"/doc/example/guacamole.properties
	doins "${S}"/doc/example/user-mapping.xml
	insinto /var/lib/"${PN}"
	newins "${S}"/target/"${P}".war "${PN}".war
	elog "Please unpack /var/lib/"${PN}"/"${PN}".war in to your servlet container! If it is an update,"
	elog "delete the old content first!"
	elog "Read: if you use the command below, delete everything expect the .war file within /var/lib/guacamole!"
	elog "Please also link /etc/guacamole in to the lib directory of your servlet container."
	elog "like this:"
	elog "cd /var/lib/guacamole && jar -xvf guacamole.war && cd .. && cp -a guacamole /var/lib/tomcat-7/webapps/"
	elog "ln -sf /etc/guacamole/guacamole.properties /usr/share/tomcat-7/lib/"
	elog "You will also need to define users and connectrions in /etc/guacamole/user-mapping.xml!"
}
