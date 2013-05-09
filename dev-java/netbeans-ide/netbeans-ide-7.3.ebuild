# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/netbeans-ide/netbeans-ide-7.3.ebuild,v 1.2 2013/05/09 14:42:21 tomwij Exp $

EAPI="4"
WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Netbeans IDE Cluster"
HOMEPAGE="http://netbeans.org/projects/ide"
SLOT="7.3"
SOURCE_URL="http://download.netbeans.org/netbeans/7.3/final/zip/netbeans-7.3-201302132200-src.zip"
SRC_URI="${SOURCE_URL}
	http://dev.gentoo.org/~fordfrog/distfiles/netbeans-7.3-build.xml.patch.bz2
	http://hg.netbeans.org/binaries/4E74C6BE42FE89871A878C7C4D6158F21A6D8010-antlr-runtime-3.4.jar
	http://hg.netbeans.org/binaries/98308890597ACB64047F7E896638E0D98753AE82-asm-all-4.0.jar
	http://hg.netbeans.org/binaries/886FAF4B85054DD6E50D9B3438542F432B5F9251-bytelist-0.1.jar
	http://hg.netbeans.org/binaries/A8762D07E76CFDE2395257A5DA47BA7C1DBD3DCE-commons-io-1.4.jar
	http://hg.netbeans.org/binaries/2298164A7C2484406F2AA5AC85B205D39019896F-commons-net-3.1.jar
	http://hg.netbeans.org/binaries/901D8F815922C435D985DA3814D20E34CC7622CB-css21-spec.zip
	http://hg.netbeans.org/binaries/53AFD6CAA1B476204557B0626E7D673FBD5D245C-css3-spec.zip
	http://hg.netbeans.org/binaries/C9A6304FAA121C97CB2458B93D30B1FD6F0F7691-derbysampledb.zip
	http://hg.netbeans.org/binaries/10535DEC87DED9981853DAE916CE356DBDB0A0FA-exechlp-1.0.zip
	http://hg.netbeans.org/binaries/7B4D200632B60DD4F102024F8E75FFEDA638EA86-glassfish-tooling-sdk-0.3-b036.1.jar
	http://hg.netbeans.org/binaries/23123BB29025254556B6E573023FCDF0F6715A66-html-4.01.zip
	http://hg.netbeans.org/binaries/77DB1AFF3C0730C144D30C9935A1CD8DCD2488A9-html5-datatypes.jar
	http://hg.netbeans.org/binaries/4388C34B9F085A42FBEA06C5B00FDF0A251171EC-html5doc.zip
	http://hg.netbeans.org/binaries/D528B44AE7593D2275927396BF930B28078C5220-htmlparser-1.2.1.jar
	http://hg.netbeans.org/binaries/8E737D82ECAC9BA6100A9BBA71E92A381B75EFDC-ini4j-0.5.1.jar
	http://hg.netbeans.org/binaries/A2862B7795EF0E0F0716BEC84528FA3B629E479C-io-xml-util.jar
	http://hg.netbeans.org/binaries/0DCC973606CBD9737541AA5F3E76DED6E3F4D0D0-iri.jar
	http://hg.netbeans.org/binaries/F90E3DA5259DB07F36E6987EFDED647A5231DE76-ispell-enwl-3.1.20.zip
	http://hg.netbeans.org/binaries/71F434378F822B09A57174AF6C75D37408687C57-jaxb-api.jar
	http://hg.netbeans.org/binaries/27FAE927B5B9AE53A5B0ED825575DD8217CE7042-jaxb-api-doc.zip
	http://hg.netbeans.org/binaries/387BE740EAEF52B3F6E6EE2F140757E7632584CE-jaxb-impl.jar
	http://hg.netbeans.org/binaries/C3787DAB0DDFBD9E98086ED2F219859B0CB77EF7-jaxb-xjc.jar
	http://hg.netbeans.org/binaries/F4DB465F207907A2406B0BF5C8FFEE22A5C3E4E3-jaxb1-impl.jar
	http://hg.netbeans.org/binaries/5E40984A55F6FFF704F05D511A119CA5B456DDB1-jfxrt.jar
	http://hg.netbeans.org/binaries/C0C5653D2200F2BD2E834B26DFDBC830D07FA0F4-jing.jar
	http://hg.netbeans.org/binaries/54C5D72D7AD60DEC4450A5CF1C361F341E6AE092-js-corestubs.zip
	http://hg.netbeans.org/binaries/0F65AE810437C2C6939B46BBE149CEFDED19FD35-js-domstubs.zip
	http://hg.netbeans.org/binaries/04E3664261A296066E6650DF19B23691979589F8-js-reststubs.zip
	http://hg.netbeans.org/binaries/2E07375E5CA3A452472F0E87FB33F243F7A5C08C-libpam4j-1.1.jar
	http://hg.netbeans.org/binaries/A3316305157479FC24CA36702355CCBD461BFE41-nashorn-5f2db2d8a7fa-patched.jar
	http://hg.netbeans.org/binaries/A1C0ED8C43A306E3FB7676E7463204B9DA9BE290-non-schema.jar
	http://hg.netbeans.org/binaries/7052E115041D04410A4519A61307502FB7C138E6-org.eclipse.core.contenttype_3.4.100.v20110423-0524.jar
	http://hg.netbeans.org/binaries/B19A4D998C76FE7A30830C96B9E3A47682F320FC-org.eclipse.core.jobs-3.5.101.jar
	http://hg.netbeans.org/binaries/E64EF6A3FC5DB01AD95632B843706CCE56614C90-org.eclipse.core.net_1.2.100.I20110511-0800.jar
	http://hg.netbeans.org/binaries/6658C235056134F7E86295E751129508802D71F2-org.eclipse.core.runtime-3.7.0.jar
	http://hg.netbeans.org/binaries/0CA9B9DF8A8E4C6805C60A5761C470FCE8AE828F-org.eclipse.core.runtime.compatibility.auth_3.2.200.v20110110.jar
	http://hg.netbeans.org/binaries/9C74D245214DB08E7EB9BC07A951B41CFE3E3648-org.eclipse.equinox.app-1.3.100.jar
	http://hg.netbeans.org/binaries/78E5D0B8516B042495660DA36CE5114650F8F156-org.eclipse.equinox.common_3.6.0.v20110523.jar
	http://hg.netbeans.org/binaries/FD94003A1BCE42008753522BFED68E5A84B92644-org.eclipse.equinox.preferences-3.4.2.jar
	http://hg.netbeans.org/binaries/54AE046B40C9095C2637F8D21664C5CD76E34485-org.eclipse.equinox.registry_3.5.200.v20120522-1841.jar
	http://hg.netbeans.org/binaries/0FFB9B1D7CD992CE6C8AAEEC2F6F98DFBB1D2F91-org.eclipse.equinox.security-1.1.1.jar
	http://hg.netbeans.org/binaries/A00DC524B1D1DB1ABBF95407AA3E6009C3D2C157-org.eclipse.jgit-1.3.0.201202151440-r.jar
	http://hg.netbeans.org/binaries/E31000A35F9FB210B18AB4F50F513F4D400BC48D-org.eclipse.mylyn.bugzilla.core_3.8.2.v20120916-1200.jar
	http://hg.netbeans.org/binaries/AE7F6FFEE9CC2E55349D325AC7504F6D09B30761-org.eclipse.mylyn.commons.core_3.8.2.v20120916-1200.jar
	http://hg.netbeans.org/binaries/3483ECE4E30CCA034BEC49979C6E735C6B1FBB13-org.eclipse.mylyn.commons.net_3.8.2.v20120916-1200.jar
	http://hg.netbeans.org/binaries/6990481339073957CCAB02AD181BFD8F186F5002-org.eclipse.mylyn.commons.repositories.core_1.0.2.v20120916-1200.jar
	http://hg.netbeans.org/binaries/68EA2A422AD4604636F50BAFD91EFD7EFC7276A4-org.eclipse.mylyn.commons.xmlrpc_3.8.2.v20120916-1200.jar
	http://hg.netbeans.org/binaries/F89D9ACAC53BA5C0D7179B473E0BFAC9BFAEE3C4-org.eclipse.mylyn.tasks.core_3.8.2.v20120916-1200.jar
	http://hg.netbeans.org/binaries/3AFA53AE20ADC7C11AF4791A85E6CECD7A5009A6-org.tmatesoft.svnkit_1.7.6.r9487_v20121029_2008.jar
	http://hg.netbeans.org/binaries/E66876EB5F33AA0E57F035F1AADD8C44FEAE7FCB-processtreekiller-1.0.1.jar
	http://hg.netbeans.org/binaries/B0D0FCBAC68826D2AFA3C7C89FC4D57B95A000C3-resolver-1.2.jar
	http://hg.netbeans.org/binaries/46C29693545F1FE541EE810F42C4A3A2A6A0DCCF-svnClientAdapter-javahl-1.8.16.jar
	http://hg.netbeans.org/binaries/B35CB146D491B0D10E468D2FEFF2DD77C746033E-svnClientAdapter-main-1.8.16.jar
	http://hg.netbeans.org/binaries/E0DC3B82DA5C95AC98AE43C4BADC741C2F56A43C-svnClientAdapter-svnkit-1.8.16.jar
	http://hg.netbeans.org/binaries/C0D8A3265D194CC886BAFD585117B6465FD97DCE-swingx-all-1.6.4.jar
	http://hg.netbeans.org/binaries/66F33A4C84AF3D30737A27CD3727330F73260D92-sqljet-1.1.5.jar
	http://hg.netbeans.org/binaries/CD5B5996B46CB8D96C8F0F89A7A734B3C01F3DF7-tomcat-webserver-3.2.jar
	http://hg.netbeans.org/binaries/24DD3B605C50A04D6C5FC129D4AD340659236EB5-com.trilead.ssh2_1.0.0.build215.jar
	http://hg.netbeans.org/binaries/89BC047153217F5254506F4C622A771A78883CBC-ValidationAPI.jar
	http://hg.netbeans.org/binaries/7A5A7DF07297A86A944D4D0562C685585B0734EF-validator.jar
	http://hg.netbeans.org/binaries/C9757EFB2CFBA523A7375A78FA9ECFAF0D0AC505-winp-1.14-patched.jar
	http://hg.netbeans.org/binaries/64F5BEEADD2A239C4BC354B8DFDB97CF7FDD9983-xmlrpc-client-3.0.jar
	http://hg.netbeans.org/binaries/8FA16AD28B5E79A7CD52B8B72985B0AE8CCD6ADF-xmlrpc-common-3.0.jar
	http://hg.netbeans.org/binaries/D6917BF718583002CBE44E773EE21E2DF08ADC71-xmlrpc-server-3.0.jar"
LICENSE="|| ( CDDL GPL-2-with-linking-exception )"
KEYWORDS="~amd64 ~x86"
IUSE=""
S="${WORKDIR}"

CDEPEND="~dev-java/netbeans-harness-${PV}
	~dev-java/netbeans-platform-${PV}
	dev-java/commons-httpclient:3
	dev-java/commons-lang:2.1
	dev-java/commons-logging:0
	dev-java/freemarker:2.3
	dev-java/icu4j:49
	dev-java/iso-relax:0
	dev-java/jdbc-mysql:0
	dev-java/jdbc-postgresql:0
	>=dev-java/json-simple-1.1:0
	dev-java/jsr173:0
	dev-java/jvyamlb:0
	dev-java/log4j:0
	dev-java/lucene:3.5
	dev-java/rhino:1.6
	dev-java/saxon:9
	dev-java/smack:2.2
	dev-java/sun-jaf:0
	dev-java/tomcat-servlet-api:2.2
	dev-java/ws-commons-util:0
	dev-java/xerces:2
	dev-vcs/subversion:0[java]"
#	app-text/jing:0 our version is probably too old
#	dev-java/commons-io:1 fails with "Missing manifest tag OpenIDE-Module"
#	dev-java/ini4j:0 our version is too old
#	dev-java/jaxb:2 upstream version contains more stuff so websvccommon does not compile with ours
#	dev-java/trilead-ssh2:0 in overlay
DEPEND=">=virtual/jdk-1.6
	app-arch/unzip
	dev-java/commons-codec:0
	dev-java/jsch:0
	dev-java/jzlib:0
	${CDEPEND}
	dev-java/javacc:0
	dev-java/javahelp:0"
RDEPEND=">=virtual/jdk-1.6
	${CDEPEND}"

INSTALL_DIR="/usr/share/${PN}-${SLOT}"

EANT_BUILD_XML="nbbuild/build.xml"
EANT_BUILD_TARGET="rebuild-cluster"
EANT_EXTRA_ARGS="-Drebuild.cluster.name=nb.cluster.ide -Dext.binaries.downloaded=true -Djava.awt.headless=true -Dpermit.jdk7.builds=true"
EANT_FILTER_COMPILER="ecj-3.3 ecj-3.4 ecj-3.5 ecj-3.6 ecj-3.7"
JAVA_PKG_BSFIX="off"

src_unpack() {
	unpack $(basename ${SOURCE_URL})

	einfo "Deleting bundled jars..."
	find -name "*.jar" -type f -delete

	unpack netbeans-7.3-build.xml.patch.bz2

	pushd "${S}" >/dev/null || die
	ln -s "${DISTDIR}"/4E74C6BE42FE89871A878C7C4D6158F21A6D8010-antlr-runtime-3.4.jar libs.antlr3.runtime/external/antlr-runtime-3.4.jar || die
	ln -s "${DISTDIR}"/98308890597ACB64047F7E896638E0D98753AE82-asm-all-4.0.jar libs.nashorn/external/asm-all-4.0.jar || die
	ln -s "${DISTDIR}"/886FAF4B85054DD6E50D9B3438542F432B5F9251-bytelist-0.1.jar libs.bytelist/external/bytelist-0.1.jar || die
	ln -s "${DISTDIR}"/A8762D07E76CFDE2395257A5DA47BA7C1DBD3DCE-commons-io-1.4.jar o.apache.commons.io/external/commons-io-1.4.jar || die
	ln -s "${DISTDIR}"/2298164A7C2484406F2AA5AC85B205D39019896F-commons-net-3.1.jar libs.commons_net/external/commons-net-3.1.jar || die
	ln -s "${DISTDIR}"/901D8F815922C435D985DA3814D20E34CC7622CB-css21-spec.zip css.editor/external/css21-spec.zip || die
	ln -s "${DISTDIR}"/53AFD6CAA1B476204557B0626E7D673FBD5D245C-css3-spec.zip css.editor/external/css3-spec.zip || die
	ln -s "${DISTDIR}"/C9A6304FAA121C97CB2458B93D30B1FD6F0F7691-derbysampledb.zip derby/external/derbysampledb.zip || die
	ln -s "${DISTDIR}"/10535DEC87DED9981853DAE916CE356DBDB0A0FA-exechlp-1.0.zip dlight.nativeexecution/external/exechlp-1.0.zip || die
	ln -s "${DISTDIR}"/7B4D200632B60DD4F102024F8E75FFEDA638EA86-glassfish-tooling-sdk-0.3-b036.1.jar libs.glassfish.sdk/external/glassfish-tooling-sdk-0.3-b036.1.jar || die
	ln -s "${DISTDIR}"/23123BB29025254556B6E573023FCDF0F6715A66-html-4.01.zip html.editor/external/html-4.01.zip || die
	ln -s "${DISTDIR}"/77DB1AFF3C0730C144D30C9935A1CD8DCD2488A9-html5-datatypes.jar html.validation/external/html5-datatypes.jar || die
	ln -s "${DISTDIR}"/4388C34B9F085A42FBEA06C5B00FDF0A251171EC-html5doc.zip html.parser/external/html5doc.zip || die
	ln -s "${DISTDIR}"/D528B44AE7593D2275927396BF930B28078C5220-htmlparser-1.2.1.jar html.parser/external/htmlparser-1.2.1.jar || die
	ln -s "${DISTDIR}"/8E737D82ECAC9BA6100A9BBA71E92A381B75EFDC-ini4j-0.5.1.jar libs.ini4j/external/ini4j-0.5.1.jar || die
	ln -s "${DISTDIR}"/A2862B7795EF0E0F0716BEC84528FA3B629E479C-io-xml-util.jar html.validation/external/io-xml-util.jar || die
	ln -s "${DISTDIR}"/0DCC973606CBD9737541AA5F3E76DED6E3F4D0D0-iri.jar html.validation/external/iri.jar || die
	ln -s "${DISTDIR}"/F90E3DA5259DB07F36E6987EFDED647A5231DE76-ispell-enwl-3.1.20.zip spellchecker.dictionary_en/external/ispell-enwl-3.1.20.zip || die
	ln -s "${DISTDIR}"/71F434378F822B09A57174AF6C75D37408687C57-jaxb-api.jar xml.jaxb.api/external/jaxb-api.jar || die
	ln -s "${DISTDIR}"/27FAE927B5B9AE53A5B0ED825575DD8217CE7042-jaxb-api-doc.zip libs.jaxb/external/jaxb-api-doc.zip || die
	ln -s "${DISTDIR}"/387BE740EAEF52B3F6E6EE2F140757E7632584CE-jaxb-impl.jar libs.jaxb/external/jaxb-impl.jar || die
	ln -s "${DISTDIR}"/C3787DAB0DDFBD9E98086ED2F219859B0CB77EF7-jaxb-xjc.jar libs.jaxb/external/jaxb-xjc.jar || die
	ln -s "${DISTDIR}"/F4DB465F207907A2406B0BF5C8FFEE22A5C3E4E3-jaxb1-impl.jar libs.jaxb/external/jaxb1-impl.jar || die
	ln -s "${DISTDIR}"/5E40984A55F6FFF704F05D511A119CA5B456DDB1-jfxrt.jar core.browser.webview/external/jfxrt.jar || die
	ln -s "${DISTDIR}"/C0C5653D2200F2BD2E834B26DFDBC830D07FA0F4-jing.jar html.validation/external/jing.jar || die
	ln -s "${DISTDIR}"/54C5D72D7AD60DEC4450A5CF1C361F341E6AE092-js-corestubs.zip javascript2.editor/external/js-corestubs.zip || die
	ln -s "${DISTDIR}"/0F65AE810437C2C6939B46BBE149CEFDED19FD35-js-domstubs.zip javascript2.editor/external/js-domstubs.zip || die
	ln -s "${DISTDIR}"/04E3664261A296066E6650DF19B23691979589F8-js-reststubs.zip javascript2.editor/external/js-reststubs.zip || die
	ln -s "${DISTDIR}"/2E07375E5CA3A452472F0E87FB33F243F7A5C08C-libpam4j-1.1.jar extexecution.impl/external/libpam4j-1.1.jar || die
	ln -s "${DISTDIR}"/A3316305157479FC24CA36702355CCBD461BFE41-nashorn-5f2db2d8a7fa-patched.jar libs.nashorn/external/nashorn-5f2db2d8a7fa-patched.jar || die
	ln -s "${DISTDIR}"/A1C0ED8C43A306E3FB7676E7463204B9DA9BE290-non-schema.jar html.validation/external/non-schema.jar || die
	ln -s "${DISTDIR}"/7052E115041D04410A4519A61307502FB7C138E6-org.eclipse.core.contenttype_3.4.100.v20110423-0524.jar o.eclipse.core.contenttype/external/org.eclipse.core.contenttype_3.4.100.v20110423-0524.jar || die
	ln -s "${DISTDIR}"/B19A4D998C76FE7A30830C96B9E3A47682F320FC-org.eclipse.core.jobs-3.5.101.jar o.eclipse.core.jobs/external/org.eclipse.core.jobs-3.5.101.jar || die
	ln -s "${DISTDIR}"/E64EF6A3FC5DB01AD95632B843706CCE56614C90-org.eclipse.core.net_1.2.100.I20110511-0800.jar o.eclipse.core.net/external/org.eclipse.core.net_1.2.100.I20110511-0800.jar || die
	ln -s "${DISTDIR}"/6658C235056134F7E86295E751129508802D71F2-org.eclipse.core.runtime-3.7.0.jar o.eclipse.core.runtime/external/org.eclipse.core.runtime-3.7.0.jar || die
	ln -s "${DISTDIR}"/0CA9B9DF8A8E4C6805C60A5761C470FCE8AE828F-org.eclipse.core.runtime.compatibility.auth_3.2.200.v20110110.jar o.eclipse.core.runtime.compatibility.auth/external/org.eclipse.core.runtime.compatibility.auth_3.2.200.v20110110.jar || die
	ln -s "${DISTDIR}"/9C74D245214DB08E7EB9BC07A951B41CFE3E3648-org.eclipse.equinox.app-1.3.100.jar o.eclipse.equinox.app/external/org.eclipse.equinox.app-1.3.100.jar || die
	ln -s "${DISTDIR}"/78E5D0B8516B042495660DA36CE5114650F8F156-org.eclipse.equinox.common_3.6.0.v20110523.jar o.eclipse.equinox.common/external/org.eclipse.equinox.common_3.6.0.v20110523.jar || die
	ln -s "${DISTDIR}"/FD94003A1BCE42008753522BFED68E5A84B92644-org.eclipse.equinox.preferences-3.4.2.jar o.eclipse.equinox.preferences/external/org.eclipse.equinox.preferences-3.4.2.jar || die
	ln -s "${DISTDIR}"/54AE046B40C9095C2637F8D21664C5CD76E34485-org.eclipse.equinox.registry_3.5.200.v20120522-1841.jar o.eclipse.equinox.registry/external/org.eclipse.equinox.registry_3.5.200.v20120522-1841.jar || die
	ln -s "${DISTDIR}"/0FFB9B1D7CD992CE6C8AAEEC2F6F98DFBB1D2F91-org.eclipse.equinox.security-1.1.1.jar o.eclipse.equinox.security/external/org.eclipse.equinox.security-1.1.1.jar || die
	ln -s "${DISTDIR}"/A00DC524B1D1DB1ABBF95407AA3E6009C3D2C157-org.eclipse.jgit-1.3.0.201202151440-r.jar o.eclipse.jgit/external/org.eclipse.jgit-1.3.0.201202151440-r.jar || die
	ln -s "${DISTDIR}"/E31000A35F9FB210B18AB4F50F513F4D400BC48D-org.eclipse.mylyn.bugzilla.core_3.8.2.v20120916-1200.jar o.eclipse.mylyn.bugzilla.core/external/org.eclipse.mylyn.bugzilla.core_3.8.2.v20120916-1200.jar || die
	ln -s "${DISTDIR}"/AE7F6FFEE9CC2E55349D325AC7504F6D09B30761-org.eclipse.mylyn.commons.core_3.8.2.v20120916-1200.jar o.eclipse.mylyn.commons.core/external/org.eclipse.mylyn.commons.core_3.8.2.v20120916-1200.jar || die
	ln -s "${DISTDIR}"/3483ECE4E30CCA034BEC49979C6E735C6B1FBB13-org.eclipse.mylyn.commons.net_3.8.2.v20120916-1200.jar o.eclipse.mylyn.commons.net/external/org.eclipse.mylyn.commons.net_3.8.2.v20120916-1200.jar  || die
	ln -s "${DISTDIR}"/6990481339073957CCAB02AD181BFD8F186F5002-org.eclipse.mylyn.commons.repositories.core_1.0.2.v20120916-1200.jar o.eclipse.mylyn.commons.repositories.core/external/org.eclipse.mylyn.commons.repositories.core_1.0.2.v20120916-1200.jar || die
	ln -s "${DISTDIR}"/68EA2A422AD4604636F50BAFD91EFD7EFC7276A4-org.eclipse.mylyn.commons.xmlrpc_3.8.2.v20120916-1200.jar o.eclipse.mylyn.commons.xmlrpc/external/org.eclipse.mylyn.commons.xmlrpc_3.8.2.v20120916-1200.jar || die
	ln -s "${DISTDIR}"/F89D9ACAC53BA5C0D7179B473E0BFAC9BFAEE3C4-org.eclipse.mylyn.tasks.core_3.8.2.v20120916-1200.jar o.eclipse.mylyn.tasks.core/external/org.eclipse.mylyn.tasks.core_3.8.2.v20120916-1200.jar || die
	ln -s "${DISTDIR}"/3AFA53AE20ADC7C11AF4791A85E6CECD7A5009A6-org.tmatesoft.svnkit_1.7.6.r9487_v20121029_2008.jar libs.svnClientAdapter.svnkit/external/org.tmatesoft.svnkit_1.7.6.r9487_v20121029_2008.jar || die
	ln -s "${DISTDIR}"/E66876EB5F33AA0E57F035F1AADD8C44FEAE7FCB-processtreekiller-1.0.1.jar extexecution.impl/external/processtreekiller-1.0.1.jar || die
	ln -s "${DISTDIR}"/B0D0FCBAC68826D2AFA3C7C89FC4D57B95A000C3-resolver-1.2.jar o.apache.xml.resolver/external/resolver-1.2.jar || die
	ln -s "${DISTDIR}"/66F33A4C84AF3D30737A27CD3727330F73260D92-sqljet-1.1.5.jar libs.svnClientAdapter.svnkit/external/sqljet-1.1.5.jar || die
	ln -s "${DISTDIR}"/46C29693545F1FE541EE810F42C4A3A2A6A0DCCF-svnClientAdapter-javahl-1.8.16.jar libs.svnClientAdapter.javahl/external/svnClientAdapter-javahl-1.8.16.jar || die
	ln -s "${DISTDIR}"/B35CB146D491B0D10E468D2FEFF2DD77C746033E-svnClientAdapter-main-1.8.16.jar libs.svnClientAdapter/external/svnClientAdapter-main-1.8.16.jar || die
	ln -s "${DISTDIR}"/E0DC3B82DA5C95AC98AE43C4BADC741C2F56A43C-svnClientAdapter-svnkit-1.8.16.jar libs.svnClientAdapter.svnkit/external/svnClientAdapter-svnkit-1.8.16.jar || die
	ln -s "${DISTDIR}"/3B91269E9055504778F57744D24F505856698602-svnkit-1.7.0-beta4-20120316.233307-1.jar libs.svnClientAdapter.svnkit/external/svnkit-1.7.0-beta4-20120316.233307-1.jar || die
	ln -s "${DISTDIR}"/015525209A02BD74254930FF844C7C13498B7FB9-svnkit-javahl16-1.7.0-beta4-20120316.233536-1.jar libs.svnClientAdapter.svnkit/external/svnkit-javahl16-1.7.0-beta4-20120316.233536-1.jar || die
	ln -s "${DISTDIR}"/C0D8A3265D194CC886BAFD585117B6465FD97DCE-swingx-all-1.6.4.jar libs.swingx/external/swingx-all-1.6.4.jar || die
	ln -s "${DISTDIR}"/CD5B5996B46CB8D96C8F0F89A7A734B3C01F3DF7-tomcat-webserver-3.2.jar httpserver/external/tomcat-webserver-3.2.jar || die
	ln -s "${DISTDIR}"/24DD3B605C50A04D6C5FC129D4AD340659236EB5-com.trilead.ssh2_1.0.0.build215.jar libs.svnClientAdapter.svnkit/external/com.trilead.ssh2_1.0.0.build215.jar || die
	ln -s "${DISTDIR}"/89BC047153217F5254506F4C622A771A78883CBC-ValidationAPI.jar swing.validation/external/ValidationAPI.jar || die
	ln -s "${DISTDIR}"/7A5A7DF07297A86A944D4D0562C685585B0734EF-validator.jar html.validation/external/validator.jar || die
	ln -s "${DISTDIR}"/64F5BEEADD2A239C4BC354B8DFDB97CF7FDD9983-xmlrpc-client-3.0.jar o.apache.xmlrpc/external/xmlrpc-client-3.0.jar || die
	ln -s "${DISTDIR}"/8FA16AD28B5E79A7CD52B8B72985B0AE8CCD6ADF-xmlrpc-common-3.0.jar o.apache.xmlrpc/external/xmlrpc-common-3.0.jar || die
	ln -s "${DISTDIR}"/D6917BF718583002CBE44E773EE21E2DF08ADC71-xmlrpc-server-3.0.jar o.apache.xmlrpc/external/xmlrpc-server-3.0.jar || die
	ln -s "${DISTDIR}"/C9757EFB2CFBA523A7375A78FA9ECFAF0D0AC505-winp-1.14-patched.jar extexecution.impl/external/winp-1.14-patched.jar || die
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
	java-pkg_jar-from --into libs.json_simple/external json-simple json-simple.jar json-simple-1.1.1.jar

	einfo "Linking in other clusters..."
	mkdir "${S}"/nbbuild/netbeans || die
	pushd "${S}"/nbbuild/netbeans >/dev/null || die

	ln -s /usr/share/netbeans-platform-${SLOT} platform || die
	cat /usr/share/netbeans-platform-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.platform.built

	ln -s /usr/share/netbeans-harness-${SLOT} harness || die
	cat /usr/share/netbeans-harness-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.harness.built

	popd >/dev/null || die

	java-pkg_jar-from --build-only --into c.jcraft.jsch/external jsch jsch.jar jsch-0.1.45.jar
	java-pkg_jar-from --build-only --into c.jcraft.jzlib/external jzlib jzlib.jar jzlib-1.0.7.jar
	java-pkg_jar-from --into db.drivers/external jdbc-mysql jdbc-mysql.jar mysql-connector-java-5.1.18-bin.jar
	java-pkg_jar-from --into db.drivers/external jdbc-postgresql jdbc-postgresql.jar postgresql-9.1-901.jdbc4.jar
	java-pkg_jar-from --build-only --into db.sql.visualeditor/external javacc javacc.jar javacc-3.2.jar
	java-pkg_jar-from --into html.parser/external icu4j-49 icu4j.jar icu4j-4_0.jar
	java-pkg_jar-from --into html.validation/external iso-relax isorelax.jar isorelax20041111.jar
	java-pkg_jar-from --into html.validation/external log4j log4j.jar log4j-1.2.15.jar
	java-pkg_jar-from --into html.validation/external rhino-1.6 js.jar js.jar
	java-pkg_jar-from --into html.validation/external saxon-9 saxon.jar saxon9B.jar
	java-pkg_jar-from --into libs.freemarker/external freemarker-2.3 freemarker.jar freemarker-2.3.8.jar
	java-pkg_jar-from --into libs.jvyamlb/external jvyamlb jvyamlb.jar jvyamlb-0.2.3.jar
	java-pkg_jar-from --into libs.lucene/external lucene-3.5 lucene-core.jar lucene-core-3.5.0.jar
	java-pkg_jar-from --into libs.smack/external smack-2.2 smack.jar smack.jar
	java-pkg_jar-from --into libs.smack/external smack-2.2 smackx.jar smackx.jar
	java-pkg_jar-from --into libs.svnClientAdapter.javahl/external subversion svn-javahl.jar svnjavahl-1.7.6.jar
	java-pkg_jar-from --into libs.xerces/external xerces-2 xercesImpl.jar xerces-2.8.0.jar
	java-pkg_jar-from --build-only --into o.apache.commons.codec/external commons-codec commons-codec.jar apache-commons-codec-1.3.jar
	java-pkg_jar-from --into o.apache.commons.httpclient/external commons-httpclient-3 commons-httpclient.jar commons-httpclient-3.1.jar
	java-pkg_jar-from --into o.apache.commons.lang/external commons-lang-2.1 commons-lang.jar commons-lang-2.4.jar
	java-pkg_jar-from --into o.apache.commons.logging/external commons-logging commons-logging.jar commons-logging-1.1.1.jar
	java-pkg_jar-from --into o.apache.ws.commons.util/external ws-commons-util ws-commons-util.jar ws-commons-util-1.0.1.jar
	java-pkg_jar-from --into servletapi/external tomcat-servlet-api-2.2 servlet.jar servlet-2.2.jar
	java-pkg_jar-from --into xml.jaxb.api/external sun-jaf activation.jar activation.jar
	java-pkg_jar-from --into xml.jaxb.api/external jsr173 jsr173.jar jsr173_1.0_api.jar

	java-pkg-2_src_prepare
}

src_compile() {
	unset DISPLAY
	eant -f ${EANT_BUILD_XML} ${EANT_EXTRA_ARGS} ${EANT_BUILD_TARGET} || die "Compilation failed"
}

src_install() {
	pushd nbbuild/netbeans/ide >/dev/null || die

	insinto ${INSTALL_DIR}

	grep -E "/ide$" ../moduleCluster.properties > "${D}"/${INSTALL_DIR}/moduleCluster.properties || die

	doins -r *
	rm -fr "${D}"/${INSTALL_DIR}/bin/nativeexecution || die
	rm -fr "${D}"/${INSTALL_DIR}/modules/lib || die

	insinto ${INSTALL_DIR}/bin/nativeexecution
	doins bin/nativeexecution/*

	pushd "${D}"/${INSTALL_DIR}/bin/nativeexecution >/dev/null || die
	for file in *.sh ; do
		fperms 755 ${file}
	done
	popd >/dev/null || die

	if use x86 ; then
		doins -r bin/nativeexecution/Linux-x86
		pushd "${D}"/${INSTALL_DIR}/bin/nativeexecution/Linux-x86 >/dev/null || die
		for file in * ; do
			fperms 755 ${file}
		done
		popd >/dev/null || die
	elif use amd64 ; then
		doins -r bin/nativeexecution/Linux-x86_64
		pushd "${D}"/${INSTALL_DIR}/bin/nativeexecution/Linux-x86_64 >/dev/null || die
		for file in * ; do
			fperms 755 ${file}
		done
		popd >/dev/null || die
	fi

	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext
	pushd "${D}"/${instdir} >/dev/null || die
	rm freemarker-2.3.8.jar && dosym /usr/share/freemarker-2.3/lib/freemarker.jar ${instdir}/freemarker-2.3.8.jar || die
	rm icu4j-4_0.jar && dosym /usr/share/icu4j-49/lib/icu4j.jar ${instdir}/icu4j-4_0.jar || die
	rm isorelax20041111.jar && dosym /usr/share/iso-relax/lib/isorelax.jar ${instdir}/isorelax20041111.jar || die
	rm js.jar && dosym /usr/share/rhino-1.6/lib/js.jar ${instdir}/js.jar || die
	rm json-simple-1.1.1.jar && dosym /usr/share/json-simple/lib/json-simple.jar ${instdir}/json-simple-1.1.1.jar || die
	rm jvyamlb-0.2.3.jar && dosym /usr/share/jvyamlb/lib/jvyamlb.jar ${instdir}/jvyamlb-0.2.3.jar || die
	rm log4j-1.2.15.jar && dosym /usr/share/log4j/lib/log4j.jar ${instdir}/log4j-1.2.15.jar || die
	rm lucene-core-3.5.0.jar && dosym /usr/share/lucene-3.5/lib/lucene-core.jar ${instdir}/lucene-core-3.5.0.jar || die
	rm mysql-connector-java-5.1.18-bin.jar && dosym /usr/share/jdbc-mysql/lib/jdbc-mysql.jar ${instdir}/mysql-connector-java-5.1.18-bin.jar || die
	rm postgresql-9.1-901.jdbc4.jar && dosym /usr/share/jdbc-postgresql/lib/jdbc-postgresql.jar ${instdir}/postgresql-9.1-901.jdbc4.jar || die
	rm saxon9B.jar && dosym /usr/share/saxon-9/lib/saxon.jar ${instdir}/saxon9B.jar || die
	rm servlet-2.2.jar && dosym /usr/share/tomcat-servlet-api-2.2/lib/servlet.jar ${instdir}/servlet-2.2.jar || die
	rm smack.jar && dosym /usr/share/smack-2.2/lib/smack.jar ${instdir}/smack.jar || die
	rm smackx.jar && dosym /usr/share/smack-2.2/lib/smackx.jar ${instdir}/smackx.jar || die
	rm svnjavahl.jar && dosym /usr/share/subversion/lib/svn-javahl.jar ${instdir}/svnjavahl.jar || die
	rm xerces-2.8.0.jar && dosym /usr/share/xerces-2/lib/xercesImpl.jar ${instdir}/xerces-2.8.0.jar || die
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/jaxb
	pushd "${D}"/${instdir} >/dev/null || die
	rm activation.jar && dosym /usr/share/sun-jaf/lib/activation.jar ${instdir}/activation.jar || die
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/jaxb/api
	pushd "${D}"/${instdir} >/dev/null || die
	rm jsr173_1.0_api.jar && dosym /usr/share/jsr173/lib/jsr173.jar ${instdir}/jsr173_1.0_api.jar || die
	popd >/dev/null || die

	dosym ${INSTALL_DIR} /usr/share/netbeans-nb-${SLOT}/ide
}
