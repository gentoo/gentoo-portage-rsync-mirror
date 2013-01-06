# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqldeveloper/sqldeveloper-2.1.1.64.45.ebuild,v 1.1 2010/08/25 12:11:42 hwoarang Exp $

EAPI="2"

inherit eutils java-pkg-2

DESCRIPTION="Oracle SQL Developer is a graphical tool for database development"
HOMEPAGE="http://www.oracle.com/technology/products/database/sql_developer/"
SRC_URI="${P}-no-jre.zip"
RESTRICT="fetch"

LICENSE="OTN"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mssql mysql sybase"

DEPEND="mssql? ( dev-java/jtds:1.2 )
	mysql? ( dev-java/jdbc-mysql:0 )
	sybase? ( dev-java/jtds:1.2 )"
RDEPEND=">=virtual/jdk-1.6.0
	${DEPEND}"

S="${WORKDIR}/${PN}"

pkg_nofetch() {
	eerror "Please go to"
	eerror "	${HOMEPAGE}"
	eerror "and download"
	eerror "	Oracle SQL Developer for other platforms"
	eerror "		${SRC_URI}"
	eerror "and move it to ${DISTDIR}"
}

src_prepare() {
	# we don't need these, do we?
	find ./ \( -iname "*.exe" -or -iname "*.dll" \) -exec rm {} \;
}

src_configure() {
	# they both use jtds, enabling one of them also enables the other one
	if use mssql && ! use sybase; then
		einfo "You requested MSSQL support, this also enables Sybase support."
	fi
	if use sybase && ! use mssql; then
		einfo "You requested Sybase support, this also enables MSSQL support."
	fi

	if use mssql || use sybase; then
		echo "AddJavaLibFile $(java-pkg_getjars jtds-1.2)" >> sqldeveloper/bin/sqldeveloper.conf
	fi

	if use mysql; then
		echo "AddJavaLibFile $(java-pkg_getjars jdbc-mysql)" >> sqldeveloper/bin/sqldeveloper.conf
	fi

	# this fixes internal Classpath warning
	cd "${T}"
	unzip -q "${S}"/jdev/extensions/oracle.jdeveloper.runner.jar META-INF/extension.xml
	sed -i 's@../../../oracle_common/modules/oracle.nlsrtl_11.1.0@../../jlib@' META-INF/extension.xml || die
	zip -rq "${S}"/jdev/extensions/oracle.jdeveloper.runner.jar META-INF/extension.xml
	rm -rf META-INF
}

src_install() {
	dodir /opt/${PN}
	cp -r {ide,j2ee,jdbc,jdev,jlib,lib,modules,rdbms,sleepycat,${PN},timingframework} \
		"${D}"/opt/${PN}/ || die "Install failed"

	dobin "${FILESDIR}"/${PN} || die "Install failed"

	mv icon.png ${PN}-32x32.png || die
	doicon ${PN}-32x32.png || die
	make_desktop_entry ${PN} "Oracle SQL Developer" ${PN}-32x32 || die

	dodoc release_notes_2.1.1.html || die

	# this fixes internal Classpath warning
	dosym /opt/sqldeveloper/jdbc/lib/ojdbc5.jar /opt/sqldeveloper/sqldeveloper/extensions/oracle.datamodeler/ojdbc5.jar
	dosym /opt/sqldeveloper/modules/oracle.xdk_11.1.0/xmlparserv2.jar /opt/sqldeveloper/sqldeveloper/extensions/oracle.datamodeler/xmlparserv2.jar
}

pkg_postinst() {
	echo
	einfo "If you want to use the TNS connection type you need to set up the"
	einfo "TNS_ADMIN environment variable to point to the directory your"
	einfo "tnsnames.ora resides in."
	echo
}
