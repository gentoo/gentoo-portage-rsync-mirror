# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/jde/jde-2.4.1_pre20110622-r1.ebuild,v 1.1 2013/05/06 12:49:46 sera Exp $

EAPI=4
NEED_EMACS=23
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2 elisp eutils

DESCRIPTION="Java Development Environment for Emacs"
HOMEPAGE="http://jdee.sourceforge.net/"
# taken from: http://jdee.svn.sourceforge.net/viewvc/jdee/trunk/jdee/?view=tar&pathrev=254
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=">=virtual/jdk-1.3
	app-emacs/elib
	virtual/emacs-cedet
	dev-java/bsh:0
	dev-java/junit:0
	dev-util/checkstyle:0"
DEPEND="${RDEPEND}
	dev-java/ant-contrib:0"

S="${WORKDIR}/jdee"
SITEFILE="70${PN}-gentoo.el"

pkg_setup() {
	java-pkg-2_pkg_setup
	elisp_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.4.0.1-fix-paths-gentoo.patch"
	epatch "${FILESDIR}/${PN}-2.4.0.1-classpath-gentoo.patch"
	epatch "${FILESDIR}/${PN}-2.4.1-doc-directory.patch"
	epatch "${FILESDIR}/${PN}-2.4.1-semantic-emacs-24.patch"

	local bshjar csjar
	bshjar=$(java-pkg_getjar --build-only bsh bsh.jar) || die
	csjar=$(java-pkg_getjar --build-only checkstyle checkstyle.jar) || die
	sed -e "s:@BSH_JAR@:${bshjar}:;s:@CHECKSTYLE_JAR@:${csjar}:" \
		-e "s:@PF@:${PF}:" "${FILESDIR}/${SITEFILE}" >"${SITEFILE}" || die

	cd java/lib || die
	java-pkg_jar-from --build-only checkstyle checkstyle.jar checkstyle-all.jar
	java-pkg_jar-from junit
	java-pkg_jar-from bsh
}

src_compile() {
	ANT_TASKS="ant-contrib" \
		eant -Delib.dir="${EPREFIX}${SITELISP}/elib" \
		bindist $(usex doc source-doc "")
}

src_install() {
	local dist="dist/jdee-${PV%_*}"

	java-pkg_dojar ${dist}/java/lib/jde.jar
	insinto "${JAVA_PKG_SHAREPATH}"
	doins -r java/bsh-commands

	use source && java-pkg_dosrc java/src/*
	use doc && java-pkg_dojavadoc ${dist}/doc/java/api

	elisp-install ${PN} ${dist}/lisp/*.{el,elc} || die
	elisp-site-file-install "${SITEFILE}" || die

	dobin ${dist}/lisp/jtags

	dohtml -r doc/html/*
}
