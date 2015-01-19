# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/fujaba/fujaba-4.2.0.ebuild,v 1.9 2015/01/19 19:41:29 monsieurp Exp $
EAPI="5"

inherit java-pkg-2

MY_PV="${PV//./_}"
MY_PNB="Fujaba_${PV:0:1}"

DESCRIPTION="The Fujaba Tool Suite provides an easy to extend UML and Java development platform"
HOMEPAGE="http://www.fujaba.de/"
SRC_URI="ftp://ftp.uni-paderborn.de/private/fujaba/${MY_PNB}/FujabaToolSuite_Developer${MY_PV}.jar"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
RDEPEND=">=virtual/jre-1.4
	=dev-java/junit-3.8*
	dev-java/log4j
	~dev-java/jdom-1.0_beta10
	=dev-java/xerces-1.3*"
DEPEND=">=virtual/jdk-1.4
	${RDEPEND}"

S=${WORKDIR}

src_unpack () {
	jar xf "${DISTDIR}"/${A}

	cd 'C_/Dokumente und Einstellungen/Lothar/Eigene Dateien/Deployment/Fujaba 4.2.0/' || die "failed to cd into package"

	rm -f Deploymentdata/libs/junit.jar
	rm -f Deploymentdata/libs/log4j*.jar
	rm -f Deploymentdata/libs/jdom*.jar
	rm -f Deploymentdata/libs/xerces.jar
}

src_install() {
	dodir /opt/${PN}
	cd 'C_/Dokumente und Einstellungen/Lothar/Eigene Dateien/Deployment/Fujaba 4.2.0/' || die "failed to cd into package"

	cp -pPR . "${D}"/opt/${PN} || die "failed to copy"
	chmod -R 755 "${D}"/opt/${PN}/

	cat > ${PN} << EOF
#!/bin/sh"
cd /opt/${PN}/Deploymentdata"
'${JAVA_HOME}'/bin/java -classpath .:\$(java-config -p xerces-1.3,log4j,junit,jdom-1.0_beta10):fujaba.jar:libs/libCoObRA.jar:libs/libXMLReflect.jar:libs/RuntimeTools.jar:libs/upb.jar de.uni_paderborn.fujaba.app.FujabaApp \$*"
EOF

	into /opt
	dobin ${PN}
}
