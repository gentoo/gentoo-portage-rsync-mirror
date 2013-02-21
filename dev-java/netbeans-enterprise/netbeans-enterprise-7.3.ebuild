# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/netbeans-enterprise/netbeans-enterprise-7.3.ebuild,v 1.1 2013/02/21 15:46:18 fordfrog Exp $

EAPI="4"
WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Netbeans Enterprise cluster"
HOMEPAGE="http://netbeans.org/"
SLOT="7.3"
SOURCE_URL="http://download.netbeans.org/netbeans/7.3/final/zip/netbeans-7.3-201302132200-src.zip"
SRC_URI="${SOURCE_URL}
	http://dev.gentoo.org/~fordfrog/distfiles/netbeans-7.3-build.xml.patch.bz2
	http://hg.netbeans.org/binaries/8BFEBCD4B39B87BBE788B4EECED068C8DBE75822-aws-java-sdk-1.2.1.jar
	http://hg.netbeans.org/binaries/A48449579E1EC9257407CCB2B15CEA2698C8B8F0-el-impl.jar
	http://hg.netbeans.org/binaries/F28E9567138D6B9AD87D79592F77874334FF5BA8-glassfish-jspparser-3.0.jar
	http://hg.netbeans.org/binaries/D813E05A06B587CD0FE36B00442EAB03C1431AA9-glassfish-logging-2.0.jar
	http://hg.netbeans.org/binaries/3D74BFB229C259E2398F2B383D5425CB81C643F0-httpclient-4.1.1.jar
	http://hg.netbeans.org/binaries/33FC26C02F8043AB0EDE19EADC8C9885386B255C-httpcore-4.1.jar
	http://hg.netbeans.org/binaries/D6F416983EA13C334D5C599A9045414ECAF5D66D-javaee-api-6.0.jar
	http://hg.netbeans.org/binaries/EBEC44255251E6D3B8DDBAF701F732DAF0238CBF-javaee-web-api-6.0.jar
	http://hg.netbeans.org/binaries/DC9A229C4AB1788D0C20D937A82FB64CE2911171-javaee6-doc-api.zip
	http://hg.netbeans.org/binaries/B290091E71DEED6CE7F9EB40523D49C26399A2B4-javax.annotation.jar
	http://hg.netbeans.org/binaries/EB77D3664EEA27D67B799ED28CB766B4D0971505-jaxb-api-osgi.jar
	http://hg.netbeans.org/binaries/FB28AE3FC7DDF97C9D33495F046680AE61F1C78C-jersey-1.13.zip
	http://hg.netbeans.org/binaries/6055EAF5B4F778A243B52D2DC4E66CB5F35B3D7C-jersey-1.13-javadoc.jar
	http://hg.netbeans.org/binaries/3ACEE9175241D421635BAD25C17F9DB218BDEAA0-jersey-apache-client-1.13-javadoc.jar
	http://hg.netbeans.org/binaries/C6C1A4D0C1ECA95E130BB8900E2CA317A3B95953-jersey-atom-abdera-1.13-javadoc.jar
	http://hg.netbeans.org/binaries/7AE3260C48C6E6FB902FCDFEBBA197FEAA3BF8AB-jersey-guice-1.13-javadoc.jar
	http://hg.netbeans.org/binaries/11379CD811D60211064899FD4A2F1EAB7C5683D8-jersey-multipart-1.13-javadoc.jar
	http://hg.netbeans.org/binaries/0B8762F12243B6D237CFF70E9AC30B88B99702AF-jersey-simple-server-1.13-javadoc.jar
	http://hg.netbeans.org/binaries/04478F287471D9B37EABC8DE4260C160087FD202-jersey-spring-1.13-javadoc.jar
	http://hg.netbeans.org/binaries/B9DB1A789C301F1D31DD6CC524DA2EBD7F89190D-jsf-1.2.zip
	http://hg.netbeans.org/binaries/99FF47EC2B4CC47631F0969B31092320C2E22329-jsf-2.1.zip
	http://hg.netbeans.org/binaries/93A58E37BA1D014375B1578F3D904736CB2D408F-jsf-api-docs.zip
	http://hg.netbeans.org/binaries/FFE3425E304F0836912D2B8ABFB5302100B39423-jsr311-api-1.1.1-javadoc.jar
	http://hg.netbeans.org/binaries/FDECFB78184C7D19E7E20130A7D7E88C1DF0BDD1-metro-1.4-doc.zip
	http://hg.netbeans.org/binaries/16CD40905B389B27AFD81DAFF8F163CEC810FBC6-metro-2.0.zip
	http://hg.netbeans.org/binaries/7AA5B0550FAD4A742E0E4345BAD930AA5187FA74-oauth-client-1.13-javadoc.jar
	http://hg.netbeans.org/binaries/5F1AE6DE4721B644307E2D36158EE059C8E05456-oauth-server-1.13-javadoc.jar
	http://hg.netbeans.org/binaries/356BA9DC7BE92AF6466262F48A833CA8A6E7081B-oauth-signature-1.13-javadoc.jar
	http://hg.netbeans.org/binaries/635C7C51EA53FC1F6692003247739353F88B9824-primefaces-3.4.jar
	http://hg.netbeans.org/binaries/A8C121019B222DAE0139299B58FDB9C71FE839F3-servlet3.0-jsp2.2-api.jar
	http://hg.netbeans.org/binaries/275C5AC6ADE12819F49E984C8E06B114A4E23458-spring-webmvc-2.5.6.SEC03.jar
	http://hg.netbeans.org/binaries/9319FDBED11E0D2EB03E4BB9E94BAA439A1DA469-struts-1.3.10-javadoc.zip
	http://hg.netbeans.org/binaries/9E226CFC08177A6666E5A2C535C25837A92C54C9-struts-1.3.10-lib.zip
	http://hg.netbeans.org/binaries/F6E990DF59BD1FD2058320002A853A5411A45CD4-syntaxref20.zip
	http://hg.netbeans.org/binaries/A5744971ACE1F44A0FC71CCB93DE530CB3022965-webservices-api-osgi.jar"
LICENSE="|| ( CDDL GPL-2-with-linking-exception )"
KEYWORDS="~amd64 ~x86"
IUSE=""
S="${WORKDIR}"

CDEPEND="~dev-java/netbeans-harness-${PV}
	~dev-java/netbeans-ide-${PV}
	~dev-java/netbeans-java-${PV}
	~dev-java/netbeans-profiler-${PV}
	~dev-java/netbeans-platform-${PV}
	~dev-java/netbeans-webcommon-${PV}
	~dev-java/netbeans-websvccommon-${PV}
	dev-java/commons-codec:0
	dev-java/commons-fileupload:0
	dev-java/commons-logging:0
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
	dev-java/commons-validator:0
	dev-java/jakarta-oro:2.0
	dev-java/jettison:0
	dev-java/jsr311-api:0"
#	dev-java/commons-chain:1.1 in overlay

INSTALL_DIR="/usr/share/${PN}-${SLOT}"

EANT_BUILD_XML="nbbuild/build.xml"
EANT_BUILD_TARGET="rebuild-cluster"
EANT_EXTRA_ARGS="-Drebuild.cluster.name=nb.cluster.enterprise -Dext.binaries.downloaded=true -Dpermit.jdk7.builds=true"
EANT_FILTER_COMPILER="ecj-3.3 ecj-3.4 ecj-3.5 ecj-3.6 ecj-3.7"
JAVA_PKG_BSFIX="off"

src_unpack() {
	unpack $(basename ${SOURCE_URL})

	einfo "Deleting bundled jars..."
	find -name "*.jar" -type f -delete

	unpack netbeans-7.3-build.xml.patch.bz2

	pushd "${S}" >/dev/null || die
	ln -s "${DISTDIR}"/8BFEBCD4B39B87BBE788B4EECED068C8DBE75822-aws-java-sdk-1.2.1.jar libs.amazon/external/aws-java-sdk-1.2.1.jar || die
	ln -s "${DISTDIR}"/A48449579E1EC9257407CCB2B15CEA2698C8B8F0-el-impl.jar libs.elimpl/external/el-impl.jar || die
	ln -s "${DISTDIR}"/F28E9567138D6B9AD87D79592F77874334FF5BA8-glassfish-jspparser-3.0.jar web.jspparser/external/glassfish-jspparser-3.0.jar || die
	ln -s "${DISTDIR}"/D813E05A06B587CD0FE36B00442EAB03C1431AA9-glassfish-logging-2.0.jar libs.glassfish_logging/external/glassfish-logging-2.0.jar || die
	ln -s "${DISTDIR}"/3D74BFB229C259E2398F2B383D5425CB81C643F0-httpclient-4.1.1.jar libs.amazon/external/httpclient-4.1.1.jar || die
	ln -s "${DISTDIR}"/33FC26C02F8043AB0EDE19EADC8C9885386B255C-httpcore-4.1.jar libs.amazon/external/httpcore-4.1.jar || die
	ln -s "${DISTDIR}"/D6F416983EA13C334D5C599A9045414ECAF5D66D-javaee-api-6.0.jar javaee.api/external/javaee-api-6.0.jar || die
	ln -s "${DISTDIR}"/EBEC44255251E6D3B8DDBAF701F732DAF0238CBF-javaee-web-api-6.0.jar javaee.api/external/javaee-web-api-6.0.jar || die
	ln -s "${DISTDIR}"/DC9A229C4AB1788D0C20D937A82FB64CE2911171-javaee6-doc-api.zip j2ee.platform/external/javaee6-doc-api.zip || die
	ln -s "${DISTDIR}"/B290091E71DEED6CE7F9EB40523D49C26399A2B4-javax.annotation.jar javaee.api/external/javax.annotation.jar || die
	ln -s "${DISTDIR}"/EB77D3664EEA27D67B799ED28CB766B4D0971505-jaxb-api-osgi.jar javaee.api/external/jaxb-api-osgi.jar || die
	ln -s "${DISTDIR}"/FB28AE3FC7DDF97C9D33495F046680AE61F1C78C-jersey-1.13.zip websvc.restlib/external/jersey-1.13.zip || die
	ln -s "${DISTDIR}"/6055EAF5B4F778A243B52D2DC4E66CB5F35B3D7C-jersey-1.13-javadoc.jar websvc.restlib/external/jersey-1.13-javadoc.jar || die
	ln -s "${DISTDIR}"/3ACEE9175241D421635BAD25C17F9DB218BDEAA0-jersey-apache-client-1.13-javadoc.jar websvc.restlib/external/jersey-apache-client-1.13-javadoc.jar || die
	ln -s "${DISTDIR}"/C6C1A4D0C1ECA95E130BB8900E2CA317A3B95953-jersey-atom-abdera-1.13-javadoc.jar websvc.restlib/external/jersey-atom-abdera-1.13-javadoc.jar || die
	ln -s "${DISTDIR}"/7AE3260C48C6E6FB902FCDFEBBA197FEAA3BF8AB-jersey-guice-1.13-javadoc.jar websvc.restlib/external/jersey-guice-1.13-javadoc.jar || die
	ln -s "${DISTDIR}"/11379CD811D60211064899FD4A2F1EAB7C5683D8-jersey-multipart-1.13-javadoc.jar websvc.restlib/external/jersey-multipart-1.13-javadoc.jar || die
	ln -s "${DISTDIR}"/0B8762F12243B6D237CFF70E9AC30B88B99702AF-jersey-simple-server-1.13-javadoc.jar websvc.restlib/external/jersey-simple-server-1.13-javadoc.jar || die
	ln -s "${DISTDIR}"/04478F287471D9B37EABC8DE4260C160087FD202-jersey-spring-1.13-javadoc.jar websvc.restlib/external/jersey-spring-1.13-javadoc.jar || die
	ln -s "${DISTDIR}"/B9DB1A789C301F1D31DD6CC524DA2EBD7F89190D-jsf-1.2.zip web.jsf12/external/jsf-1.2.zip || die
	ln -s "${DISTDIR}"/99FF47EC2B4CC47631F0969B31092320C2E22329-jsf-2.1.zip web.jsf20/external/jsf-2.1.zip || die
	ln -s "${DISTDIR}"/93A58E37BA1D014375B1578F3D904736CB2D408F-jsf-api-docs.zip web.jsf.editor/external/jsf-api-docs.zip || die
	ln -s "${DISTDIR}"/FFE3425E304F0836912D2B8ABFB5302100B39423-jsr311-api-1.1.1-javadoc.jar websvc.restlib/external/jsr311-api-1.1.1-javadoc.jar || die
	ln -s "${DISTDIR}"/FDECFB78184C7D19E7E20130A7D7E88C1DF0BDD1-metro-1.4-doc.zip websvc.metro.lib/external/metro-1.4-doc.zip || die
	ln -s "${DISTDIR}"/16CD40905B389B27AFD81DAFF8F163CEC810FBC6-metro-2.0.zip websvc.metro.lib/external/metro-2.0.zip || die
	ln -s "${DISTDIR}"/7AA5B0550FAD4A742E0E4345BAD930AA5187FA74-oauth-client-1.13-javadoc.jar websvc.restlib/external/oauth-client-1.13-javadoc.jar || die
	ln -s "${DISTDIR}"/5F1AE6DE4721B644307E2D36158EE059C8E05456-oauth-server-1.13-javadoc.jar websvc.restlib/external/oauth-server-1.13-javadoc.jar || die
	ln -s "${DISTDIR}"/356BA9DC7BE92AF6466262F48A833CA8A6E7081B-oauth-signature-1.13-javadoc.jar websvc.restlib/external/oauth-signature-1.13-javadoc.jar || die
	ln -s "${DISTDIR}"/635C7C51EA53FC1F6692003247739353F88B9824-primefaces-3.4.jar web.primefaces/external/primefaces-3.4.jar || die
	ln -s "${DISTDIR}"/A8C121019B222DAE0139299B58FDB9C71FE839F3-servlet3.0-jsp2.2-api.jar servletjspapi/external/servlet3.0-jsp2.2-api.jar || die
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

	epatch netbeans-7.3-build.xml.patch

	# Support for custom patches
	if [ -n "${NETBEANS73_PATCHES_DIR}" -a -d "${NETBEANS73_PATCHES_DIR}" ] ; then
		local files=`find "${NETBEANS73_PATCHES_DIR}" -type f`

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
	java-pkg_jar-from --into libs.amazon/external commons-codec commons-codec.jar commons-codec-1.3.jar
	java-pkg_jar-from --into libs.amazon/external commons-logging commons-logging.jar commons-logging-1.1.1.jar
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

	ln -s /usr/share/netbeans-webcommon-${SLOT} webcommon || die
	cat /usr/share/netbeans-webcommon-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.webcommon.built

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
	rm jsr88javax.jar && dosym /usr/share/glassfish-deployment-api-1.2/lib/glassfish-deployment-api.jar ${instdir}/jsr88javax.jar || die
	rm jstl.jar && dosym /usr/share/jakarta-jstl/lib/jstl.jar ${instdir}/jstl.jar || die
	rm standard.jar && dosym /usr/share/jakarta-jstl/lib/standard.jar ${instdir}/standard.jar || die
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/aws-sdk
	pushd "${D}"/${instdir} >/dev/null || die
	rm commons-codec-1.3.jar && dosym /usr/share/commons-codec/lib/commons-codec.jar ${instdir}/commons-codec-1.3.jar || die
	rm commons-logging-1.1.1.jar && dosym /usr/share/commons-logging/lib/commons-logging.jar ${instdir}/commons-logging-1.1.1.jar || die
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/jsf-1_2
	pushd "${D}"/${instdir} >/dev/null || die
	rm commons-beanutils.jar && dosym /usr/share/commons-beanutils-1.7/lib/commons-beanutils.jar ${instdir}/commons-beanutils.jar || die
	rm commons-collections.jar && dosym /usr/share/commons-collections/lib/commons-collections.jar ${instdir}/commons-collections.jar || die
	rm commons-digester.jar && dosym /usr/share/commons-digester/lib/commons-digester.jar ${instdir}/commons-digester.jar || die
	rm commons-logging.jar && dosym /usr/share/commons-logging/lib/commons-logging.jar ${instdir}/commons-logging.jar || die
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/rest
	pushd "${D}"/${instdir} >/dev/null || die
	rm asm-3.1.jar && dosym /usr/share/asm-3/lib/asm.jar ${instdir}/asm-3.1.jar || die
	rm jettison-1.1.jar && dosym /usr/share/jettison/lib/jettison.jar ${instdir}/jettison-1.1.jar || die
	rm jsr311-api-1.1.1.jar && dosym /usr/share/jsr311-api/lib/jsr311-api.jar ${instdir}/jsr311-api-1.1.1.jar || die
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/struts
	pushd "${D}"/${instdir} >/dev/null || die
	rm antlr-2.7.2.jar && dosym /usr/share/antlr/lib/antlr.jar ${instdir}/antlr-2.7.2.jar || die
	rm bsf-2.3.0.jar && dosym /usr/share/bsf-2.3/lib/bsf.jar ${instdir}/bsf-2.3.0.jar || die
	rm commons-beanutils-1.8.0.jar && dosym /usr/share/commons-beanutils-1.7/lib/commons-beanutils.jar ${instdir}/commons-beanutils-1.8.0.jar || die
	rm commons-digester-1.8.jar && dosym /usr/share/commons-digester/lib/commons-digester.jar ${instdir}/commons-digester-1.8.jar || die
	rm commons-fileupload-1.1.1.jar && dosym /usr/share/commons-fileupload/lib/commons-fileupload.jar ${instdir}/commons-fileupload-1.1.1.jar || die
	rm commons-io-1.1.jar && dosym /usr/share/commons-io-1/lib/commons-io.jar ${instdir}/commons-io-1.1.jar || die
	rm commons-logging-1.0.4.jar && dosym /usr/share/commons-logging/lib/commons-logging.jar ${instdir}/commons-logging-1.0.4.jar || die
	rm commons-validator-1.3.1.jar && dosym /usr/share/commons-validator/lib/commons-validator.jar ${instdir}/commons-validator-1.3.1.jar || die
	rm jstl-1.0.2.jar && dosym /usr/share/jakarta-jstl/lib/jstl.jar ${instdir}/jstl-1.0.2.jar || die
	rm oro-2.0.8.jar && dosym /usr/share/jakarta-oro-2.0/lib/jakarta-oro.jar ${instdir}/oro-2.0.8.jar || die
	rm standard-1.0.6.jar && dosym /usr/share/jakarta-jstl/lib/standard.jar ${instdir}/standard-1.0.6.jar || die
	popd >/dev/null || die

	dosym ${INSTALL_DIR} /usr/share/netbeans-nb-${SLOT}/enterprise
}
