# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/freemind/freemind-0.8.0-r3.ebuild,v 1.7 2008/10/05 13:35:01 betelgeuse Exp $

inherit java-pkg-2 java-ant-2 eutils

MY_PV=${PV//./_}

DESCRIPTION="Mind-mapping software written in Java"
HOMEPAGE="http://freemind.sf.net"
SRC_URI="mirror://sourceforge/freemind/${PN}-src-${MY_PV}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# patch for JDK 1.6 (see bug #109678)
	epatch "${FILESDIR}/${P}-source.patch"
}

src_compile() {
	eant dist browser $(use_doc doc)
}

src_install() {
	cd "${WORKDIR}/bin/dist"

	insinto /opt/${PN}/
	doins -r lib/ browser/ plugins/
	doins -r accessories/ user.properties patterns.xml

	java-pkg_regjar /opt/${PN}/lib/${PN}.jar

	cp -R "${S}/doc" "${D}/opt/${PN}"
	use doc && java-pkg_dojavadoc doc/javadoc

	into /opt
	java-pkg_dolauncher ${PN} --pwd /opt/${PN} --jar /opt/${PN}/lib/${PN}.jar

	mv "${S}/images/FreeMindWindowIcon.png" "${S}/images/freemind.png"
	doicon "${S}/images/freemind.png"

	make_desktop_entry freemind Freemind freemind Utility
}
