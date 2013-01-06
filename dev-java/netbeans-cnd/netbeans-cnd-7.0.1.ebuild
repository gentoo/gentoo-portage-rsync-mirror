# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/netbeans-cnd/netbeans-cnd-7.0.1.ebuild,v 1.4 2012/12/06 12:25:30 fordfrog Exp $

EAPI="4"
WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Netbeans CND Cluster"
HOMEPAGE="http://netbeans.org/projects/cnd"
SLOT="7.0"
SOURCE_URL="http://download.netbeans.org/netbeans/7.0.1/final/zip/netbeans-7.0.1-201107282000-src.zip"
SRC_URI="${SOURCE_URL}
	http://dev.gentoo.org/~fordfrog/distfiles/netbeans-${SLOT}-build.xml-r1.patch.bz2
	http://hg.netbeans.org/binaries/5C917BCC015510DC6C7E3B511DB85B2978C0774C-cnd-build-trace-1.0.zip
	http://hg.netbeans.org/binaries/84F10BEAA967E2896F0B43B0BBD08D834841F554-cnd-rfs-1.0.zip
	http://hg.netbeans.org/binaries/296C195B720404C2683BA2F65E2A423DD0611B8B-open-fortran-parser-0.7.1.2.zip"
LICENSE="|| ( CDDL GPL-2-with-linking-exception )"
KEYWORDS="~amd64 ~x86"
IUSE=""
S="${WORKDIR}"

# These files are for remote development and debugging
QA_PREBUILT="usr/share/netbeans-cnd-${SLOT}/bin/*"

CDEPEND="~dev-java/netbeans-dlight-${PV}
	~dev-java/netbeans-harness-${PV}
	~dev-java/netbeans-ide-${PV}
	~dev-java/netbeans-platform-${PV}"
DEPEND="virtual/jdk:1.6
	app-arch/unzip
	${CDEPEND}
	dev-java/antlr:0[java]
	dev-java/antlr:3
	dev-java/javahelp:0
	dev-java/stringtemplate:0"
RDEPEND=">=virtual/jdk-1.6
	${CDEPEND}"

INSTALL_DIR="/usr/share/${PN}-${SLOT}"

EANT_BUILD_XML="nbbuild/build.xml"
EANT_BUILD_TARGET="rebuild-cluster"
EANT_EXTRA_ARGS="-Drebuild.cluster.name=nb.cluster.cnd -Dext.binaries.downloaded=true"
EANT_FILTER_COMPILER="ecj-3.3 ecj-3.4 ecj-3.5 ecj-3.6 ecj-3.7"
JAVA_PKG_BSFIX="off"

src_unpack() {
	unpack $(basename ${SOURCE_URL})

	einfo "Deleting bundled jars..."
	find -name "*.jar" -type f -delete

	unpack netbeans-7.0-build.xml-r1.patch.bz2

	pushd "${S}" >/dev/null || die
	ln -s "${DISTDIR}"/5C917BCC015510DC6C7E3B511DB85B2978C0774C-cnd-build-trace-1.0.zip cnd.discovery/external/cnd-build-trace-1.0.zip || die
	ln -s "${DISTDIR}"/84F10BEAA967E2896F0B43B0BBD08D834841F554-cnd-rfs-1.0.zip cnd.remote/external/cnd-rfs-1.0.zip || die
	ln -s "${DISTDIR}"/296C195B720404C2683BA2F65E2A423DD0611B8B-open-fortran-parser-0.7.1.2.zip cnd.modelimpl/external/open-fortran-parser-0.7.1.2.zip || die
	popd >/dev/null || die
}

src_prepare() {
	einfo "Deleting bundled class files..."
	find -name "*.class" -type f | xargs rm -vf

	epatch netbeans-7.0-build.xml-r1.patch
	sed -i "s%<classpath path=\"\${antlr3.jar}\"/>%<classpath path=\"\${antlr3.jar}:../libs.antlr3.devel/external/antlr-2.7.jar:../libs.antlr3.devel/external/stringtemplate-3.2.jar\"/>%" cnd.modelimpl/build.xml || die

	# Support for custom patches
	if [ -n "${NETBEANS70_PATCHES_DIR}" -a -d "${NETBEANS70_PATCHES_DIR}" ] ; then
		local files=`find "${NETBEANS70_PATCHES_DIR}" -type f`

		if [ -n "${files}" ] ; then
			einfo "Applying custom patches:"

			for file in ${files} ; do
				epatch "${file}"
			done
		fi
	fi

	einfo "Symlinking external libraries..."
	java-pkg_jar-from --build-only --into javahelp/external javahelp jhall.jar jhall-2.0_05.jar
	java-pkg_jar-from --build-only --into libs.antlr3.devel/external antlr-3 antlr3.jar antlr-3.1.3.jar
	java-pkg_jar-from --build-only --into libs.antlr3.devel/external antlr antlr.jar antlr-2.7.jar
	java-pkg_jar-from --build-only --into libs.antlr3.devel/external stringtemplate stringtemplate.jar stringtemplate-3.2.jar

	einfo "Linking in other clusters..."
	mkdir "${S}"/nbbuild/netbeans || die
	pushd "${S}"/nbbuild/netbeans >/dev/null || die

	ln -s /usr/share/netbeans-dlight-${SLOT} dlight || die
	cat /usr/share/netbeans-dlight-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.dlight.built

	ln -s /usr/share/netbeans-harness-${SLOT} harness || die
	cat /usr/share/netbeans-harness-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.harness.built

	ln -s /usr/share/netbeans-ide-${SLOT} ide || die
	cat /usr/share/netbeans-ide-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.ide.built

	ln -s /usr/share/netbeans-platform-${SLOT} platform || die
	cat /usr/share/netbeans-platform-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.platform.built

	popd >/dev/null || die

	java-pkg-2_src_prepare
}

src_install() {
	pushd nbbuild/netbeans/cnd >/dev/null || die

	insinto ${INSTALL_DIR}

	grep -E "/cnd$" ../moduleCluster.properties > "${D}"/${INSTALL_DIR}/moduleCluster.properties || die

	doins -r *
	fperms 755 bin/dorun.sh

	popd >/dev/null || die

	dosym ${INSTALL_DIR} /usr/share/netbeans-nb-${SLOT}/cnd
}
