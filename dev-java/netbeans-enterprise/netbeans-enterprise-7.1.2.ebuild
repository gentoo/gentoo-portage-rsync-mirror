# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/netbeans-enterprise/netbeans-enterprise-7.1.2.ebuild,v 1.3 2012/05/30 06:00:50 johu Exp $

EAPI="4"
WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Netbeans Enterprise cluster"
HOMEPAGE="http://netbeans.org/"
SLOT="7.1"
SOURCE_URL="http://dlc.sun.com.edgesuite.net/netbeans/7.1.2/final/zip/netbeans-7.1.2-201204101705-src.zip"
SRC_URI="${SOURCE_URL}
	http://dev.gentoo.org/~fordfrog/distfiles/netbeans-9999-r1-build.xml.patch.bz2
	http://hg.netbeans.org/binaries/2EA8E5BDC70E1B1D738140E52E4793385B2567A3-el-impl.jar
	http://hg.netbeans.org/binaries/7763236B189D9B910E2BDBA6822E6EB4DDDAC41B-glassfish-jspparser-3.0.jar
	http://hg.netbeans.org/binaries/D813E05A06B587CD0FE36B00442EAB03C1431AA9-glassfish-logging-2.0.jar
	http://hg.netbeans.org/binaries/D6F416983EA13C334D5C599A9045414ECAF5D66D-javaee-api-6.0.jar
	http://hg.netbeans.org/binaries/EBEC44255251E6D3B8DDBAF701F732DAF0238CBF-javaee-web-api-6.0.jar
	http://hg.netbeans.org/binaries/DC9A229C4AB1788D0C20D937A82FB64CE2911171-javaee6-doc-api.zip
	http://hg.netbeans.org/binaries/B290091E71DEED6CE7F9EB40523D49C26399A2B4-javax.annotation.jar
	http://hg.netbeans.org/binaries/EB77D3664EEA27D67B799ED28CB766B4D0971505-jaxb-api-osgi.jar
	http://hg.netbeans.org/binaries/EEBA5E4DCFB946A8E9CAAF1AC405620E28710BEE-jersey-1.8.zip
	http://hg.netbeans.org/binaries/6055EAF5B4F778A243B52D2DC4E66CB5F35B3D7C-jersey-1.8-javadoc.jar
	http://hg.netbeans.org/binaries/4D9B1037036E99811D9E393F191058C9CA30CAE2-jersey-apache-client-1.8-javadoc.jar
	http://hg.netbeans.org/binaries/2503B5FDE71D6BE1CE44BADA3257A6F310E3BB67-jersey-atom-abdera-1.8-javadoc.jar
	http://hg.netbeans.org/binaries/955396DB8CE0477C6BD70BA830FF84CB9B7AB47B-jersey-client-1.3-javadoc.jar
	http://hg.netbeans.org/binaries/A27843863A5EAE9DDFF1C70F7A95D3BFC2A59D99-jersey-core-1.1.5.1-javadoc.jar
	http://hg.netbeans.org/binaries/3E5011972CEDE87E5ADCF9A90351A106DAEE2FC2-jersey-guice-1.8-javadoc.jar
	http://hg.netbeans.org/binaries/6E3105315F3100F65D66355B04BA6B6C2B8480D3-jersey-json-1.3-javadoc.jar
	http://hg.netbeans.org/binaries/0EE4D36A33681C945339BB1B594F4C0ED9A4C3DE-jersey-multipart-1.8-javadoc.jar
	http://hg.netbeans.org/binaries/D77C6E4AA0F3D3C9B7230F6C0991DBBF0CEF39BA-jersey-simple-server-1.8-javadoc.jar
	http://hg.netbeans.org/binaries/454F67445E0740C3414476812F2DFD17DA2AF0A3-jersey-spring-1.8-javadoc.jar
	http://hg.netbeans.org/binaries/B9DB1A789C301F1D31DD6CC524DA2EBD7F89190D-jsf-1.2.zip
	http://hg.netbeans.org/binaries/1D74DA79DC71C52D1B7916853BDD51F346A85359-jsf-2.1.zip
	http://hg.netbeans.org/binaries/93A58E37BA1D014375B1578F3D904736CB2D408F-jsf-api-docs.zip
	http://hg.netbeans.org/binaries/FFE3425E304F0836912D2B8ABFB5302100B39423-jsr311-api-1.1.1-javadoc.jar
	http://hg.netbeans.org/binaries/FDECFB78184C7D19E7E20130A7D7E88C1DF0BDD1-metro-1.4-doc.zip
	http://hg.netbeans.org/binaries/16CD40905B389B27AFD81DAFF8F163CEC810FBC6-metro-2.0.zip
	http://hg.netbeans.org/binaries/942DF8FA6174168BD227E925B11672E9A321D5BB-oauth-client-1.8-javadoc.jar
	http://hg.netbeans.org/binaries/1C6E6C4B3DC659E5720AB08E2972C7C0459E5387-oauth-server-1.8-javadoc.jar
	http://hg.netbeans.org/binaries/6EC53F24E6F4D9DBC884076FD0190B9C79414070-oauth-signature-1.8-javadoc.jar
	http://hg.netbeans.org/binaries/C31A6E33D7D6E77C8123A0830D929187A9707147-primefaces-2.2.1.jar
	http://hg.netbeans.org/binaries/B9FA9CDC7FA5203E1DB5C4DBAAED0133596D524F-servlet3.0-jsp2.2-api.jar
	http://hg.netbeans.org/binaries/275C5AC6ADE12819F49E984C8E06B114A4E23458-spring-webmvc-2.5.6.SEC03.jar
	http://hg.netbeans.org/binaries/9319FDBED11E0D2EB03E4BB9E94BAA439A1DA469-struts-1.3.10-javadoc.zip
	http://hg.netbeans.org/binaries/9E226CFC08177A6666E5A2C535C25837A92C54C9-struts-1.3.10-lib.zip
	http://hg.netbeans.org/binaries/F6E990DF59BD1FD2058320002A853A5411A45CD4-syntaxref20.zip
	http://hg.netbeans.org/binaries/A5744971ACE1F44A0FC71CCB93DE530CB3022965-webservices-api-osgi.jar"
LICENSE="|| ( CDDL GPL-2-with-linking-exception )"
KEYWORDS="amd64 x86"
IUSE=""
S="${WORKDIR}"

CDEPEND="~dev-java/netbeans-harness-${PV}
	~dev-java/netbeans-ide-${PV}
	~dev-java/netbeans-java-${PV}
	~dev-java/netbeans-profiler-${PV}
	~dev-java/netbeans-platform-${PV}
	~dev-java/netbeans-websvccommon-${PV}
	dev-java/commons-fileupload:0
	dev-java/glassfish-deployment-api:1.2
	dev-java/jakarta-jstl:0"
DEPEND="virtual/jdk:1.6
	app-arch/unzip
	${CDEPEND}
	dev-java/javahelp:0
	>=dev-java/junit-4.4:4
	dev-java/tomcat-servlet-api:2.3"
RDEPEND=">=virtual/jdk-1.6
	${CDEPEND}
	dev-java/antlr:0[java]
	dev-java/asm:3
	dev-java/bsf:2.3
	dev-java/commons-beanutils:1.7
	dev-java/commons-collections:0
	dev-java/commons-digester:0
	dev-java/commons-io:1
	dev-java/commons-logging:0
	dev-java/commons-validator:0
	dev-java/jakarta-oro:2.0
	dev-java/jettison:0
	dev-java/jsr311-api:0"
#	dev-java/commons-chain:1.1 in overlay

INSTALL_DIR="/usr/share/${PN}-${SLOT}"

EANT_BUILD_XML="nbbuild/build.xml"
EANT_BUILD_TARGET="rebuild-cluster"
EANT_EXTRA_ARGS="-Drebuild.cluster.name=nb.cluster.enterprise -Dext.binaries.downloaded=true"
EANT_FILTER_COMPILER="ecj-3.3 ecj-3.4 ecj-3.5 ecj-3.6 ecj-3.7"
JAVA_PKG_BSFIX="off"

src_unpack() {
	unpack $(basename ${SOURCE_URL})

	einfo "Deleting bundled jars..."
	find -name "*.jar" -type f -delete

	unpack netbeans-9999-r1-build.xml.patch.bz2

	pushd "${S}" >/dev/null || die
	ln -s "${DISTDIR}"/2EA8E5BDC70E1B1D738140E52E4793385B2567A3-el-impl.jar libs.elimpl/external/el-impl.jar || die
	ln -s "${DISTDIR}"/7763236B189D9B910E2BDBA6822E6EB4DDDAC41B-glassfish-jspparser-3.0.jar web.jspparser/external/glassfish-jspparser-3.0.jar || die
	ln -s "${DISTDIR}"/D813E05A06B587CD0FE36B00442EAB03C1431AA9-glassfish-logging-2.0.jar libs.glassfish_logging/external/glassfish-logging-2.0.jar || die
	ln -s "${DISTDIR}"/D6F416983EA13C334D5C599A9045414ECAF5D66D-javaee-api-6.0.jar javaee.api/external/javaee-api-6.0.jar || die
	ln -s "${DISTDIR}"/EBEC44255251E6D3B8DDBAF701F732DAF0238CBF-javaee-web-api-6.0.jar javaee.api/external/javaee-web-api-6.0.jar || die
	ln -s "${DISTDIR}"/DC9A229C4AB1788D0C20D937A82FB64CE2911171-javaee6-doc-api.zip j2ee.platform/external/javaee6-doc-api.zip || die
	ln -s "${DISTDIR}"/B290091E71DEED6CE7F9EB40523D49C26399A2B4-javax.annotation.jar javaee.api/external/javax.annotation.jar || die
	ln -s "${DISTDIR}"/EB77D3664EEA27D67B799ED28CB766B4D0971505-jaxb-api-osgi.jar javaee.api/external/jaxb-api-osgi.jar || die
	ln -s "${DISTDIR}"/EEBA5E4DCFB946A8E9CAAF1AC405620E28710BEE-jersey-1.8.zip websvc.restlib/external/jersey-1.8.zip || die
	ln -s "${DISTDIR}"/6055EAF5B4F778A243B52D2DC4E66CB5F35B3D7C-jersey-1.8-javadoc.jar websvc.restlib/external/jersey-1.8-javadoc.jar || die
	ln -s "${DISTDIR}"/4D9B1037036E99811D9E393F191058C9CA30CAE2-jersey-apache-client-1.8-javadoc.jar websvc.restlib/external/jersey-apache-client-1.8-javadoc.jar || die
	ln -s "${DISTDIR}"/2503B5FDE71D6BE1CE44BADA3257A6F310E3BB67-jersey-atom-abdera-1.8-javadoc.jar websvc.restlib/external/jersey-atom-abdera-1.8-javadoc.jar || die
	ln -s "${DISTDIR}"/955396DB8CE0477C6BD70BA830FF84CB9B7AB47B-jersey-client-1.3-javadoc.jar websvc.restlib/external/jersey-client-1.3-javadoc.jar || die
	ln -s "${DISTDIR}"/A27843863A5EAE9DDFF1C70F7A95D3BFC2A59D99-jersey-core-1.1.5.1-javadoc.jar websvc.restlib/external/jersey-core-1.1.5.1-javadoc.jar || die
	ln -s "${DISTDIR}"/3E5011972CEDE87E5ADCF9A90351A106DAEE2FC2-jersey-guice-1.8-javadoc.jar websvc.restlib/external/jersey-guice-1.8-javadoc.jar || die
	ln -s "${DISTDIR}"/6E3105315F3100F65D66355B04BA6B6C2B8480D3-jersey-json-1.3-javadoc.jar websvc.restlib/external/jersey-json-1.3-javadoc.jar || die
	ln -s "${DISTDIR}"/0EE4D36A33681C945339BB1B594F4C0ED9A4C3DE-jersey-multipart-1.8-javadoc.jar websvc.restlib/external/jersey-multipart-1.8-javadoc.jar || die
	ln -s "${DISTDIR}"/D77C6E4AA0F3D3C9B7230F6C0991DBBF0CEF39BA-jersey-simple-server-1.8-javadoc.jar websvc.restlib/external/jersey-simple-server-1.8-javadoc.jar || die
	ln -s "${DISTDIR}"/454F67445E0740C3414476812F2DFD17DA2AF0A3-jersey-spring-1.8-javadoc.jar websvc.restlib/external/jersey-spring-1.8-javadoc.jar || die
	ln -s "${DISTDIR}"/B9DB1A789C301F1D31DD6CC524DA2EBD7F89190D-jsf-1.2.zip web.jsf12/external/jsf-1.2.zip || die
	ln -s "${DISTDIR}"/1D74DA79DC71C52D1B7916853BDD51F346A85359-jsf-2.1.zip web.jsf20/external/jsf-2.1.zip || die
	ln -s "${DISTDIR}"/93A58E37BA1D014375B1578F3D904736CB2D408F-jsf-api-docs.zip web.jsf.editor/external/jsf-api-docs.zip || die
	ln -s "${DISTDIR}"/FFE3425E304F0836912D2B8ABFB5302100B39423-jsr311-api-1.1.1-javadoc.jar websvc.restlib/external/jsr311-api-1.1.1-javadoc.jar || die
	ln -s "${DISTDIR}"/FDECFB78184C7D19E7E20130A7D7E88C1DF0BDD1-metro-1.4-doc.zip websvc.metro.lib/external/metro-1.4-doc.zip || die
	ln -s "${DISTDIR}"/16CD40905B389B27AFD81DAFF8F163CEC810FBC6-metro-2.0.zip websvc.metro.lib/external/metro-2.0.zip || die
	ln -s "${DISTDIR}"/942DF8FA6174168BD227E925B11672E9A321D5BB-oauth-client-1.8-javadoc.jar websvc.restlib/external/oauth-client-1.8-javadoc.jar || die
	ln -s "${DISTDIR}"/1C6E6C4B3DC659E5720AB08E2972C7C0459E5387-oauth-server-1.8-javadoc.jar websvc.restlib/external/oauth-server-1.8-javadoc.jar || die
	ln -s "${DISTDIR}"/6EC53F24E6F4D9DBC884076FD0190B9C79414070-oauth-signature-1.8-javadoc.jar websvc.restlib/external/oauth-signature-1.8-javadoc.jar || die
	ln -s "${DISTDIR}"/C31A6E33D7D6E77C8123A0830D929187A9707147-primefaces-2.2.1.jar web.primefaces/external/primefaces-2.2.1.jar || die
	ln -s "${DISTDIR}"/B9FA9CDC7FA5203E1DB5C4DBAAED0133596D524F-servlet3.0-jsp2.2-api.jar servletjspapi/external/servlet3.0-jsp2.2-api.jar || die
	ln -s "${DISTDIR}"/275C5AC6ADE12819F49E984C8E06B114A4E23458-spring-webmvc-2.5.6.SEC03.jar spring.webmvc/external/spring-webmvc-2.5.6.SEC03.jar || die
	ln -s "${DISTDIR}"/9319FDBED11E0D2EB03E4BB9E94BAA439A1DA469-struts-1.3.10-javadoc.zip web.struts/external/struts-1.3.10-javadoc.zip || die
	ln -s "${DISTDIR}"/9E226CFC08177A6666E5A2C535C25837A92C54C9-struts-1.3.10-lib.zip web.struts/external/struts-1.3.10-lib.zip || die
	ln -s "${DISTDIR}"/F6E990DF59BD1FD2058320002A853A5411A45CD4-syntaxref20.zip web.core.syntax/external/syntaxref20.zip || die
	ln -s "${DISTDIR}"/A5744971ACE1F44A0FC71CCB93DE530CB3022965-webservices-api-osgi.jar javaee.api/external/webservices-api-osgi.jar || die
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
	java-pkg_jar-from --into j2eeapis/external glassfish-deployment-api-1.2 glassfish-deployment-api.jar jsr88javax.jar
	java-pkg_jar-from --into libs.commons_fileupload/external commons-fileupload commons-fileupload.jar commons-fileupload-1.0.jar
	java-pkg_jar-from --into web.jstl11/external jakarta-jstl jstl.jar jstl-1.1.2.jar
	java-pkg_jar-from --into web.jstl11/external jakarta-jstl standard.jar standard-1.1.2.jar
	java-pkg_jar-from --build-only --into libs.junit4/external junit-4 junit.jar junit-4.10.jar
	java-pkg_jar-from --build-only --into web.monitor/external tomcat-servlet-api-2.3 servlet.jar servlet-2.3.jar

	einfo "Linking in other clusters..."
	mkdir "${S}"/nbbuild/netbeans || die
	pushd "${S}"/nbbuild/netbeans >/dev/null || die

	ln -s /usr/share/netbeans-harness-${SLOT} harness || die
	cat /usr/share/netbeans-harness-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.harness.built

	ln -s /usr/share/netbeans-ide-${SLOT} ide || die
	cat /usr/share/netbeans-ide-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.ide.built

	ln -s /usr/share/netbeans-java-${SLOT} java || die
	cat /usr/share/netbeans-java-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.java.built

	ln -s /usr/share/netbeans-profiler-${SLOT} profiler || die
	cat /usr/share/netbeans-profiler-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.profiler.built

	ln -s /usr/share/netbeans-platform-${SLOT} platform || die
	cat /usr/share/netbeans-platform-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.platform.built

	ln -s /usr/share/netbeans-websvccommon-${SLOT} websvccommon || die
	cat /usr/share/netbeans-websvccommon-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.websvccommon.built

	popd >/dev/null || die

	java-pkg-2_src_prepare
}

src_install() {
	pushd nbbuild/netbeans/enterprise >/dev/null || die

	insinto ${INSTALL_DIR}

	grep -E "/enterprise$" ../moduleCluster.properties > "${D}"/${INSTALL_DIR}/moduleCluster.properties || die

	doins -r *

	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext
	pushd "${D}"/${instdir} >/dev/null || die
	rm commons-fileupload-1.0.jar && dosym /usr/share/commons-fileupload/lib/commons-fileupload.jar ${instdir}/commons-fileupload-1.0.jar || die
	# el-impl.jar
	# glassfish-jspparser-3.0.jar
	# glassfish-logging-2.0.jar
	# javaee-api-6.0.jar
	# javaee-api-6.0-license.txt
	# javaee-web-api-6.0.jar
	# javaee-web-api-6.0-license.txt
	# jsp-parser-ext.jar
	rm jsr88javax.jar && dosym /usr/share/glassfish-deployment-api-1.2/lib/glassfish-deployment-api.jar ${instdir}/jsr88javax.jar || die
	rm jstl.jar && dosym /usr/share/jakarta-jstl/lib/jstl.jar ${instdir}/jstl.jar || die
	# org-netbeans-modules-web-httpmonitor.jar
	# servlet3.0-jsp2.2-api.jar
	rm standard.jar && dosym /usr/share/jakarta-jstl/lib/standard.jar ${instdir}/standard.jar || die
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/javaee6-endorsed
	pushd "${D}"/${instdir} >/dev/null || die
	# javax.annotation.jar
	# javax.annotation-license.txt
	# jaxb-api-osgi.jar
	# jaxb-api-osgi-license.txt
	# webservices-api-osgi.jar
	# webservices-api-osgi-license.txt
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/jsf-1_2
	pushd "${D}"/${instdir} >/dev/null || die
	rm commons-beanutils.jar && dosym /usr/share/commons-beanutils-1.7/lib/commons-beanutils.jar ${instdir}/commons-beanutils.jar || die
	rm commons-collections.jar && dosym /usr/share/commons-collections/lib/commons-collections.jar ${instdir}/commons-collections.jar || die
	rm commons-digester.jar && dosym /usr/share/commons-digester/lib/commons-digester.jar ${instdir}/commons-digester.jar || die
	rm commons-logging.jar && dosym /usr/share/commons-logging/lib/commons-logging.jar ${instdir}/commons-logging.jar || die
	# jsf-api.jar
	# jsf-impl.jar
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/jsf-2_1
	pushd "${D}"/${instdir} >/dev/null || die
	# jsf-api.jar
	# jsf-impl.jar
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/metro
	pushd "${D}"/${instdir} >/dev/null || die
	# webservices-api.jar
	# webservices-extra-api.jar
	# webservices-extra.jar
	# webservices-rt.jar
	# webservices-tools.jar
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/primefaces
	pushd "${D}"/${instdir} >/dev/null || die
	# primefaces-2.1.jar
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/rest
	pushd "${D}"/${instdir} >/dev/null || die
	rm asm-3.1.jar && dosym /usr/share/asm-3/lib/asm.jar ${instdir}/asm-3.1.jar || die
	# jackson-core-asl-1.1.1.jar
	# jersey-client-1.3.jar
	# jersey-core-1.3.jar
	# jersey-json-1.3.jar
	# jersey-multipart-1.3.jar
	# jersey-server-1.3.jar
	# jersey-spring-1.3.jar
	rm jettison-1.1.jar && dosym /usr/share/jettison/lib/jettison.jar ${instdir}/jettison-1.1.jar || die
	rm jsr311-api-1.1.1.jar && dosym /usr/share/jsr311-api/lib/jsr311-api.jar ${instdir}/jsr311-api-1.1.1.jar || die
	# mimepull-1.4.jar
	# oauth-client-1.3.jar
	# oauth-signature-1.3.jar
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/spring
	pushd "${D}"/${instdir} >/dev/null || die
	# spring-webmvc-2.5.6.SEC01.jar
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/struts
	pushd "${D}"/${instdir} >/dev/null || die
	rm antlr-2.7.2.jar && dosym /usr/share/antlr/lib/antlr.jar ${instdir}/antlr-2.7.2.jar || die
	rm bsf-2.3.0.jar && dosym /usr/share/bsf-2.3/lib/bsf.jar ${instdir}/bsf-2.3.0.jar || die
	rm commons-beanutils-1.8.0.jar && dosym /usr/share/commons-beanutils-1.7/lib/commons-beanutils.jar ${instdir}/commons-beanutils-1.8.0.jar || die
	rm commons-digester-1.8.jar && dosym /usr/share/commons-digester/lib/commons-digester.jar ${instdir}/commons-digester-1.8.jar || die
	rm commons-fileupload-1.1.1.jar && dosym /usr/share/commons-fileupload/lib/commons-fileupload.jar ${instdir}/commons-fileupload-1.1.1.jar || die
	# rm commons-chain-1.1.jar && dosym /usr/share/commons-chain-1.1/lib/commons-chain.jar ${instdir}/commons-chain-1.1.jar || die
	rm commons-io-1.1.jar && dosym /usr/share/commons-io-1/lib/commons-io.jar ${instdir}/commons-io-1.1.jar || die
	rm commons-logging-1.0.4.jar && dosym /usr/share/commons-logging/lib/commons-logging.jar ${instdir}/commons-logging-1.0.4.jar || die
	rm commons-validator-1.3.1.jar && dosym /usr/share/commons-validator/lib/commons-validator.jar ${instdir}/commons-validator-1.3.1.jar || die
	rm jstl-1.0.2.jar && dosym /usr/share/jakarta-jstl/lib/jstl.jar ${instdir}/jstl-1.0.2.jar || die
	rm oro-2.0.8.jar && dosym /usr/share/jakarta-oro-2.0/lib/jakarta-oro.jar ${instdir}/oro-2.0.8.jar || die
	rm standard-1.0.6.jar && dosym /usr/share/jakarta-jstl/lib/standard.jar ${instdir}/standard-1.0.6.jar || die
	# struts-core-1.3.8.jar
	# struts-el-1.3.8.jar
	# struts-extras-1.3.8.jar
	# struts-faces-1.3.8.jar
	# struts-mailreader-dao-1.3.8.jar
	# struts-scripting-1.3.8.jar
	# struts-taglib-1.3.8.jar
	# struts-tiles-1.3.8.jar
	popd >/dev/null || die

	dosym ${INSTALL_DIR} /usr/share/netbeans-nb-${SLOT}/enterprise
}
