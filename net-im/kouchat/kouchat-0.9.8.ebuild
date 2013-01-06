# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kouchat/kouchat-0.9.8.ebuild,v 1.4 2012/05/21 19:37:47 ssuominen Exp $

EAPI=1
JAVA_PKG_IUSE="doc source test"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="KouChat is a simple serverless chat client for local area networks."
HOMEPAGE="http://kouchat.googlecode.com/"
SRC_URI="http://kouchat.googlecode.com/files/${P}-src.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6
	test?
	(
		dev-java/junit:4
		dev-java/ant-junit4
	)"

S="${WORKDIR}/${P}-src"

src_unpack() {
	unpack ${A}
	cp -v "${FILESDIR}"/build.xml "${S}" || die
}

src_install() {
	java-pkg_dojar ${PN}.jar
	use doc && java-pkg_dojavadoc docs
	use source && java-pkg_dosrc src/net
	java-pkg_dolauncher ${PN} --main net.usikkert.kouchat.KouChat
	java-pkg_dolauncher ${PN}-console --main net.usikkert.kouchat.KouChat --pkg_args "--console"
	newicon kou_shortcut.png ${PN}.png
	make_desktop_entry ${PN} "KouChat"
}

src_test() {
	ANT_TASKS="ant-junit4" eant -Djunit4.jar=$(java-pkg_getjar junit-4 junit.jar) test
}
