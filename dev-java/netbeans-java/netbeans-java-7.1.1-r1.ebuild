# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/netbeans-java/netbeans-java-7.1.1-r1.ebuild,v 1.4 2012/12/06 13:02:31 fordfrog Exp $

EAPI="4"
WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Netbeans Java Cluster"
HOMEPAGE="http://netbeans.org/projects/java"
SLOT="7.1"
SOURCE_URL="http://dlc.sun.com.edgesuite.net/netbeans/7.1.1/final/zip/netbeans-7.1.1-201203012225-src.zip"
SRC_URI="${SOURCE_URL}
	http://dev.gentoo.org/~fordfrog/distfiles/netbeans-9999-r1-build.xml.patch.bz2
	http://hg.netbeans.org/binaries/FF23DBB427D09AAEC3998B50D740C42B6A3FCD61-ant-libs-1.8.2.zip
	http://hg.netbeans.org/binaries/29CFD351206016B67DD0D556098513D2B259C69B-apache-maven-3.0.4-bin.zip
	http://hg.netbeans.org/binaries/F7BD95641780C2AAE8CB9BED1686441A1CE5E749-beansbinding-1.2.1-doc.zip
	http://hg.netbeans.org/binaries/BC0919190ADD3A7FB764C8412D10A2B026CD9563-eclipselink-2.3.0.jar
	http://hg.netbeans.org/binaries/7C60F22D32F56478AC25A732038E9DD7DFECF5DD-eclipselink-jpa-modelgen-2.3.0.jar
	http://hg.netbeans.org/binaries/59FAD2A4D4A1CFECED8149854EEEC3A7B9668927-glassfish-persistence-v2-build-58g.jar
	http://hg.netbeans.org/binaries/907363E301E2279930C82BEB466BF2053C6E993B-glassfish-persistence-v2ur1-build-09d.jar
	http://hg.netbeans.org/binaries/C8A5E0D558EA7E7349F9D32B838553D5E7DD214F-hibernate-3.2.5-lib.zip
	http://hg.netbeans.org/binaries/204680C59C7D8A4A1A26B9A2ED46D0DAA6DC10B3-indexer-artifact-4.1.2.jar
	http://hg.netbeans.org/binaries/EA1F2B2504FC5ABCB06146D858F74A97B85A2998-indexer-core-4.1.2.jar
	http://hg.netbeans.org/binaries/E90F4B2F8972AA5EF58139F16B78D5F6ACFC6EF9-javac-api-nb-7.0-b07.jar
	http://hg.netbeans.org/binaries/8BA05B53DB763AA62EFD389B2F1C8CFA889079EF-javac-impl-nb-7.0-b07.jar
	http://hg.netbeans.org/binaries/3BCA561B1B7B284B3D3C097F92A9CD47FF485058-javax.persistence-2.0.jar
	http://hg.netbeans.org/binaries/2F43A634A42CC4FD2EF9E24B488AFFD6984D3411-jaxws-2.2.zip
	http://hg.netbeans.org/binaries/23E69F0F17757673C573EBD9899727B82EF7DB7F-jaxws-2.2-api.zip
	http://hg.netbeans.org/binaries/8ECD169E9E308C258287E4F28B03B6D6F1E55F47-jaxws-api-doc.zip
	http://hg.netbeans.org/binaries/653A6AD1EF786BC577FC20F56E5F2B1D30423805-maven-dependency-tree-1.2.jar
	http://hg.netbeans.org/binaries/3D4C3416889FDC5C149D97382020F4AC6C736377-org.eclipse.persistence.jpa.jpql_1.0.0.jar
	http://hg.netbeans.org/binaries/2D0D28E05BD6B6452DAAFE2B5CCB69A84EA63E5D-spring-2.5.6.SEC01.jar
	http://hg.netbeans.org/binaries/7622CB23DAEDD9DE0ACBD16C820D3A02F94572AF-spring-framework-3.0.6.RELEASE.zip"
LICENSE="|| ( CDDL GPL-2-with-linking-exception )"
KEYWORDS="amd64 x86"
IUSE=""
S="${WORKDIR}"

CDEPEND="~dev-java/netbeans-platform-${PV}
	~dev-java/netbeans-harness-${PV}
	~dev-java/netbeans-ide-${PV}
	~dev-java/netbeans-websvccommon-${PV}
	dev-java/beansbinding:0
	dev-java/cglib:2.2
	dev-java/jdom:1.0"
DEPEND="virtual/jdk:1.6
	app-arch/unzip
	${CDEPEND}
	dev-java/javahelp:0
	dev-java/junit:4"
RDEPEND=">=virtual/jdk-1.6
	${CDEPEND}
	dev-java/absolutelayout:0
	dev-java/antlr:0[java]
	dev-java/asm:2.2
	dev-java/cglib:2.1
	dev-java/commons-collections:0
	dev-java/dom4j:1
	dev-java/ehcache:1.2
	dev-java/fastinfoset:0
	dev-java/javassist:3
	dev-java/jsr67:0
	dev-java/jsr181:0
	dev-java/jsr250:0
	dev-java/glassfish-transaction-api:0
	dev-java/jtidy:0
	dev-java/saaj:0
	dev-java/stax-ex:0
	dev-java/xmlstreambuffer:0"

INSTALL_DIR="/usr/share/${PN}-${SLOT}"

EANT_BUILD_XML="nbbuild/build.xml"
EANT_BUILD_TARGET="rebuild-cluster"
EANT_EXTRA_ARGS="-Drebuild.cluster.name=nb.cluster.java -Dext.binaries.downloaded=true"
EANT_FILTER_COMPILER="ecj-3.3 ecj-3.4 ecj-3.5 ecj-3.6 ecj-3.7"
JAVA_PKG_BSFIX="off"

pkg_pretend() {
	local die_now=""

	if [ -d /usr/share/netbeans-java-${SLOT}/ant -a -n "$(find /usr/share/netbeans-java-${SLOT}/ant -type l)" ]; then
		eerror "Please remove following symlinks and run emerge again:"
		find /usr/share/netbeans-java-${SLOT}/ant -type l
		die_now="1"
	fi

	if [ -L /usr/share/netbeans-java-${SLOT}/maven ]; then
		if [ -z "${die_now}" ]; then
			eerror "Please remove following symlinks and run emerge again:"
		fi

		echo "/usr/share/netbeans-java-${SLOT}/maven"
		die_now="1"
	fi

	if [ -n "${die_now}" ]; then
		die "Symlinks exist"
	fi
}

src_unpack() {
	unpack $(basename ${SOURCE_URL})

	einfo "Deleting bundled jars..."
	find -name "*.jar" -type f -delete

	unpack netbeans-9999-r1-build.xml.patch.bz2

	pushd "${S}" >/dev/null || die
	ln -s "${DISTDIR}"/FF23DBB427D09AAEC3998B50D740C42B6A3FCD61-ant-libs-1.8.2.zip o.apache.tools.ant.module/external/ant-libs-1.8.2.zip || die
	ln -s "${DISTDIR}"/29CFD351206016B67DD0D556098513D2B259C69B-apache-maven-3.0.4-bin.zip maven.embedder/external/apache-maven-3.0.4-bin.zip || die
	ln -s "${DISTDIR}"/F7BD95641780C2AAE8CB9BED1686441A1CE5E749-beansbinding-1.2.1-doc.zip o.jdesktop.beansbinding/external/beansbinding-1.2.1-doc.zip || die
	ln -s "${DISTDIR}"/BC0919190ADD3A7FB764C8412D10A2B026CD9563-eclipselink-2.3.0.jar j2ee.eclipselink/external/eclipselink-2.3.0.jar || die
	ln -s "${DISTDIR}"/7C60F22D32F56478AC25A732038E9DD7DFECF5DD-eclipselink-jpa-modelgen-2.3.0.jar j2ee.eclipselinkmodelgen/external/eclipselink-jpa-modelgen-2.3.0.jar || die
	ln -s "${DISTDIR}"/59FAD2A4D4A1CFECED8149854EEEC3A7B9668927-glassfish-persistence-v2-build-58g.jar j2ee.toplinklib/external/glassfish-persistence-v2-build-58g.jar || die
	ln -s "${DISTDIR}"/907363E301E2279930C82BEB466BF2053C6E993B-glassfish-persistence-v2ur1-build-09d.jar j2ee.toplinklib/external/glassfish-persistence-v2ur1-build-09d.jar || die
	ln -s "${DISTDIR}"/C8A5E0D558EA7E7349F9D32B838553D5E7DD214F-hibernate-3.2.5-lib.zip hibernatelib/external/hibernate-3.2.5-lib.zip || die
	ln -s "${DISTDIR}"/204680C59C7D8A4A1A26B9A2ED46D0DAA6DC10B3-indexer-artifact-4.1.2.jar maven.indexer/external/indexer-artifact-4.1.2.jar || die
	ln -s "${DISTDIR}"/EA1F2B2504FC5ABCB06146D858F74A97B85A2998-indexer-core-4.1.2.jar maven.indexer/external/indexer-core-4.1.2.jar || die
	ln -s "${DISTDIR}"/E90F4B2F8972AA5EF58139F16B78D5F6ACFC6EF9-javac-api-nb-7.0-b07.jar libs.javacapi/external/javac-api-nb-7.0-b07.jar || die
	ln -s "${DISTDIR}"/8BA05B53DB763AA62EFD389B2F1C8CFA889079EF-javac-impl-nb-7.0-b07.jar libs.javacimpl/external/javac-impl-nb-7.0-b07.jar || die
	ln -s "${DISTDIR}"/3BCA561B1B7B284B3D3C097F92A9CD47FF485058-javax.persistence-2.0.jar j2ee.eclipselink/external/javax.persistence-2.0.jar || die
	ln -s "${DISTDIR}"/2F43A634A42CC4FD2EF9E24B488AFFD6984D3411-jaxws-2.2.zip websvc.jaxws21/external/jaxws-2.2.zip || die
	ln -s "${DISTDIR}"/23E69F0F17757673C573EBD9899727B82EF7DB7F-jaxws-2.2-api.zip websvc.jaxws21api/external/jaxws-2.2-api.zip || die
	ln -s "${DISTDIR}"/8ECD169E9E308C258287E4F28B03B6D6F1E55F47-jaxws-api-doc.zip websvc.jaxws21/external/jaxws-api-doc.zip || die
	ln -s "${DISTDIR}"/653A6AD1EF786BC577FC20F56E5F2B1D30423805-maven-dependency-tree-1.2.jar maven.embedder/external/maven-dependency-tree-1.2.jar || die
	ln -s "${DISTDIR}"/3D4C3416889FDC5C149D97382020F4AC6C736377-org.eclipse.persistence.jpa.jpql_1.0.0.jar j2ee.eclipselink/external/org.eclipse.persistence.jpa.jpql_1.0.0.jar || die
	ln -s "${DISTDIR}"/2D0D28E05BD6B6452DAAFE2B5CCB69A84EA63E5D-spring-2.5.6.SEC01.jar libs.springframework/external/spring-2.5.6.SEC01.jar || die
	ln -s "${DISTDIR}"/7622CB23DAEDD9DE0ACBD16C820D3A02F94572AF-spring-framework-3.0.6.RELEASE.zip libs.springframework/external/spring-framework-3.0.6.RELEASE.zip || die
	popd >/dev/null || die
}

src_prepare() {
	einfo "Deleting bundled class files..."
	find -name "*.class" -type f | xargs rm -vf

	epatch netbeans-9999-r1-build.xml.patch

	# Support for custom patches
	if [ -n "${NETBEANS9999_PATCHES_DIR}" -a -d "${NETBEANS9999_PATCHES_DIR}" ] ; then
		local files=`find "${NETBEANS9999_PATCHES_DIR}" -type f`

		if [ -n "${files}" ] ; then
			einfo "Applying custom patches:"

			for file in ${files} ; do
				epatch "${file}"
			done
		fi
	fi

	einfo "Symlinking external libraries..."
	java-pkg_jar-from --build-only --into javahelp/external javahelp jhall.jar jhall-2.0_05.jar
	java-pkg_jar-from --into libs.cglib/external cglib-2.2 cglib.jar cglib-2.2.jar
	java-pkg_jar-from --build-only --into libs.junit4/external junit-4 junit.jar junit-4.10.jar
	java-pkg_jar-from --into maven.embedder/external jdom-1.0 jdom.jar jdom-1.0.jar
	java-pkg_jar-from --into o.jdesktop.beansbinding/external beansbinding beansbinding.jar beansbinding-1.2.1.jar

	einfo "Linking in other clusters..."
	mkdir "${S}"/nbbuild/netbeans || die
	pushd "${S}"/nbbuild/netbeans >/dev/null || die

	ln -s /usr/share/netbeans-platform-${SLOT} platform || die
	cat /usr/share/netbeans-platform-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.platform.built

	ln -s /usr/share/netbeans-harness-${SLOT} harness || die
	cat /usr/share/netbeans-harness-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.harness.built

	ln -s /usr/share/netbeans-ide-${SLOT} ide || die
	cat /usr/share/netbeans-ide-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.ide.built

	ln -s /usr/share/netbeans-websvccommon-${SLOT} websvccommon || die
	cat /usr/share/netbeans-websvccommon-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.websvccommon.built

	popd >/dev/null || die

	java-pkg-2_src_prepare
}

src_install() {
	pushd nbbuild/netbeans/java >/dev/null || die

	insinto ${INSTALL_DIR}
	grep -E "/java$" ../moduleCluster.properties > "${D}"/${INSTALL_DIR}/moduleCluster.properties || die

	doins -r *
	#rm -fr "${D}"/${INSTALL_DIR}/ant/* || die
	#rm -fr "${D}"/${INSTALL_DIR}/maven || die
	#dosym /usr/share/maven-bin-3.0 ${INSTALL_DIR}/maven
	chmod 755 "${D}"/${INSTALL_DIR}/maven/bin/mvn* || die
	rm -fr "${D}"/${INSTALL_DIR}/maven/bin/*.bat || die

	#insinto ${INSTALL_DIR}/ant
	#dosym /usr/share/ant/bin ${INSTALL_DIR}/ant/bin
	#dosym /usr/share/ant/etc ${INSTALL_DIR}/ant/etc
	#doins -r ant/extra
	#dosym /usr/share/ant/lib ${INSTALL_DIR}/ant/lib
	#doins -r ant/nblib
	#dosym /usr/share/ant/tasks ${INSTALL_DIR}/ant/tasks
	#local vertasks=$(ls -d /usr/share/ant/tasks-*)
	#dosym ${vertasks} ${INSTALL_DIR}/ant/$(basename ${vertasks}) # it would be better if ant would have tasks-current dir

	popd >/dev/null || die

	local instdir=/${INSTALL_DIR}/modules/ext
	pushd "${D}"/${instdir} >/dev/null || die
	rm AbsoluteLayout.jar  && dosym /usr/share/absolutelayout/lib/absolutelayout.jar ${instdir}/AbsoluteLayout.jar || die
	rm beansbinding-1.2.1.jar && dosym /usr/share/beansbinding/lib/beansbinding.jar ${instdir}/beansbinding-1.2.1.jar || die
	rm cglib-2.2.jar && dosym /usr/share/cglib-2.2/lib/cglib.jar ${instdir}/cglib-2.2.jar || die
	# javac-api-nb-7.0-b07.jar
	# javac-impl-nb-7.0-b07.jar
	# org-netbeans-modules-java-j2seplatform-probe.jar
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/eclipselink
	pushd "${D}"/${instdir} >/dev/null || die
	# dir: eclipselink
	# eclipselink-javax.persistence-2.0.jar
	# eclipselink-jpa-modelgen-2.2.0.jar
	# eclipselink-2.2.0.jar
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/hibernate
	pushd "${D}"/${instdir} >/dev/null || die
	rm antlr-2.7.6.jar && dosym /usr/share/antlr/lib/antlr.jar ${instdir}/antlr-2.7.6.jar || die
	rm asm-attrs.jar && dosym /usr/share/asm-2.2/lib/asm-attrs.jar ${instdir}/asm-attrs.jar || die
	rm asm.jar && dosym /usr/share/asm-2.2/lib/asm.jar ${instdir}/asm.jar || die
	rm cglib-2.1.3.jar && dosym /usr/share/cglib-2.1/lib/cglib.jar ${instdir}/cglib-2.1.3.jar || die
	rm commons-collections-2.1.1.jar && dosym /usr/share/commons-collections/lib/commons-collections.jar ${instdir}/commons-collections-2.1.1.jar || die
	rm dom4j-1.6.1.jar && dosym /usr/share/dom4j-1/lib/dom4j.jar ${instdir}/dom4j-1.6.1.jar || die
	rm ehcache-1.2.3.jar && dosym /usr/share/ehcache-1.2/lib/ehcache.jar ${instdir}/ehcache-1.2.3.jar || die
	# ejb3-persistence.jar
	# hibernate-annotations.jar
	# hibernate-commons-annotations.jar
	# hibernate-entitymanager.jar
	# hibernate-tools.jar
	# hibernate3.jar
	rm javassist.jar && dosym /usr/share/javassist-3/lib/javassist.jar ${instdir}/javassist.jar || die
	# jdbc2_0-stdext.jar
	rm jta.jar && dosym /usr/share/jta/lib/jta.jar ${instdir}/jta.jar || die
	rm jtidy-r8-20060801.jar && dosym /usr/share/jtidy/lib/Tidy.jar ${instdir}/jtidy-r8-20060801.jar || die
	popd >/dev/null || die

	local instdir=/${INSTALL_DIR}/modules/ext/jaxws22
	pushd "${D}"/${instdir} >/dev/null || die
	rm FastInfoset.jar && dosym /usr/share/fastinfoset/lib/fastinfoset.jar ${instdir}/FastInfoset.jar || die
	# gmbal-api-only.jar
	# http.jar
	# jaxws-rt.jar
	# jaxws-tools.jar
	# management-api.jar
	# mimepull.jar
	# policy.jar
	rm saaj-impl.jar && dosym /usr/share/saaj/lib/saaj.jar ${instdir}/saaj-impl.jar || die
	rm stax-ex.jar && dosym /usr/share/stax-ex/lib/stax-ex.jar ${instdir}/stax-ex.jar || die
	rm streambuffer.jar && dosym /usr/share/xmlstreambuffer/lib/streambuffer.jar ${instdir}/streambuffer.jar || die
	# woodstox.jar
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/jaxws22/api
	pushd "${D}"/${instdir} >/dev/null || die
	# jaxws-api.jar
	rm jsr181-api.jar && dosym /usr/share/jsr181/lib/jsr181.jar ${instdir}/jsr181-api.jar || die
	rm jsr250-api.jar && dosym /usr/share/jsr250/lib/jsr250.jar ${instdir}/jsr250-api.jar || die
	rm saaj-api.jar && dosym /usr/share/jsr67/lib/jsr67.jar ${instdir}/saaj-api.jar || die
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/maven
	pushd "${D}"/${instdir} >/dev/null || die
	# indexer-artifact-4.1.1.jar
	# indexer-core-4.1.1.jar
	rm jdom-1.0.jar && dosym /usr/share/jdom-1.0/lib/jdom.jar ${instdir}/jdom-1.0.jar || die
	# maven-dependency-tree-1.2.jar
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/spring
	pushd "${D}"/${instdir} >/dev/null || die
	# spring-2.5.6.SEC01.jar
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/spring-3.0
	pushd "${D}"/${instdir} >/dev/null || die
	# spring-aop-3.0.2.RELEASE.jar
	# spring-asm-3.0.2.RELEASE.jar
	# spring-aspects-3.0.2.RELEASE.jar
	# spring-beans-3.0.2.RELEASE.jar
	# spring-context-support-3.0.2.RELEASE.jar
	# spring-context-3.0.2.RELEASE.jar
	# spring-core-3.0.2.RELEASE.jar
	# spring-expression-3.0.2.RELEASE.jar
	# spring-instrument-tomcat-3.0.2.RELEASE.jar
	# spring-instrument-3.0.2.RELEASE.jar
	# spring-jdbc-3.0.2.RELEASE.jar
	# spring-jms-3.0.2.RELEASE.jar
	# spring-orm-3.0.2.RELEASE.jar
	# spring-oxm-3.0.2.RELEASE.jar
	# spring-struts-3.0.2.RELEASE.jar
	# spring-test-3.0.2.RELEASE.jar
	# spring-tx-3.0.2.RELEASE.jar
	# spring-webmvc-portlet-3.0.2.RELEASE.jar
	# spring-webmvc-3.0.2.RELEASE.jar
	# spring-web-3.0.2.RELEASE.jar
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/toplink
	pushd "${D}"/${instdir} >/dev/null || die
	# toplink-essentials-agent.jar
	# toplink-essentials.jar
	popd >/dev/null || die

	dosym ${INSTALL_DIR} /usr/share/netbeans-nb-${SLOT}/java
}
