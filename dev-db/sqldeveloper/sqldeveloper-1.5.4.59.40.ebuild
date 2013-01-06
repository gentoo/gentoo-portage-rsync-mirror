# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqldeveloper/sqldeveloper-1.5.4.59.40.ebuild,v 1.3 2010/07/19 06:00:51 betelgeuse Exp $

EAPI="2"

inherit eutils java-pkg-2

DESCRIPTION="Oracle SQL Developer is a graphical tool for database development"
HOMEPAGE="http://www.oracle.com/technology/products/database/sql_developer/"
SRC_URI="${P}-no-jre.zip"
RESTRICT="fetch"

LICENSE="OTN"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="mssql mysql sybase"

DEPEND="mssql? ( dev-java/jtds:1.2 )
	mysql? ( dev-java/jdbc-mysql:0 )
	sybase? ( dev-java/jtds:1.2 )"
RDEPEND=">=virtual/jre-1.5.0
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
	find ./ -iname "*.exe" -or -iname "*.dll" -exec rm {} \;
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
		echo "AddJavaLibFile $(java-pkg_getjars jtds-1.2)"
			>> sqldeveloper/bin/sqldeveloper.conf
	fi

	if use mysql; then
		echo "AddJavaLibFile $(java-pkg_getjars jdbc-mysql)"
			>> sqldeveloper/bin/sqldeveloper.conf
	fi
}

src_install() {
	dodir /opt/${PN}
	cp -r {BC4J,dvt,ide,j2ee,jdbc,jdev,jlib,lib,rdbms,${PN},timingframework} \
		"${D}"/opt/${PN}/ || die "Install failed"

	dobin "${FILESDIR}"/${PN} || die "Install failed"

	mv icon.png ${PN}-32x32.png
	mv raptor_image.jpg ${PN}-48x48.jpg
	doicon ${PN}-32x32.png ${PN}-48x48.jpg
	make_desktop_entry ${PN} "Oracle SQL Developer" ${PN}-32x32

	dodoc relnotes.html
}

pkg_postinst() {
	echo
	einfo "If you want to use the TNS connection type you need to set up the"
	einfo "TNS_ADMIN environment variable to point to the directory your"
	einfo "tnsnames.ora resides in."
	echo
}
