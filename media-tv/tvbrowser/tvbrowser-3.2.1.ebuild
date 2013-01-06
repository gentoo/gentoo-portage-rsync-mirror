# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/tvbrowser/tvbrowser-3.2.1.ebuild,v 1.1 2012/11/12 21:38:13 johu Exp $

EAPI=4

JAVA_PKG_IUSE="doc source test"
inherit eutils java-pkg-2 java-ant-2 flag-o-matic

DESCRIPTION="Themeable and easy to use TV Guide - written in Java"
HOMEPAGE="http://www.tvbrowser.org/"
SRC_URI="mirror://sourceforge/${PN}/${P/-/_}_src.zip

themes? (
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/BeOSthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/amarachthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/aquathemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/architectBluethemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/architectOlivethemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/b0sumiErgothempack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/b0sumithemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/bbjthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/beigeazulthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/beosthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/blueMetalthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/blueTurquesathemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/cellshadedthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/chaNinja-Bluethemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/coronaHthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/cougarthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/crystal2themepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/fatalEthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/gfxOasisthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/gorillathemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/hmmXPBluethemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/hmmXPMonoBluethemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/iBarthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/macosthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/midnightthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/mmMagra-Xthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/modernthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/oliveGreenLunaXPthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/opusLunaSilverthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/opusOSBluethemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/opusOSDeepthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/opusOSOlivethemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/quickSilverRthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/roueBluethemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/roueBrownthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/roueGreenthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/royalInspiratthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/silverLunaXPthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/solunaRthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/tigerGraphitethemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/tigerthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/toxicthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/underlingthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/whistlerthemepack.zip
	http://javootoo.l2fprod.com/plaf/skinlf/themepacks/xplunathemepack.zip

	http://tvbrowser.org/downloads/noia.zip
	http://tvbrowser.org/downloads/nuvola.zip
	http://tvbrowser.org/downloads/tulliana.zip
	http://tvbrowser.org/downloads/tango_without_heart.zip
)"

SLOT="0"
KEYWORDS="~x86 ~amd64"
LICENSE="GPL-3"

IUSE="themes"

COMMON_DEP="dev-java/bsh
	>=dev-java/commons-codec-1.4
	>=dev-java/commons-lang-2.4
	>=dev-java/commons-net-1.4.1
	>=dev-java/jakarta-oro-2.0.8
	>=dev-java/jgoodies-forms-1.3.0
	>=dev-java/jgoodies-looks-2.3.1
	dev-java/l2fprod-common
	dev-java/log4j
	dev-java/skinlf
	>=dev-java/stax-1.2.0
	dev-java/xalan
	x11-libs/libXt
	x11-libs/libSM
	x11-libs/libICE
	x11-libs/libXext
	x11-libs/libXtst
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
"
DEPEND="${COMMON_DEP}
	app-arch/unzip
	>=virtual/jdk-1.6
	test? ( dev-java/junit:0 )
"
RDEPEND="${COMMON_DEP}
	>=virtual/jre-1.6
"

# javac errors about missing junit, lets investigate this later
RESTRICT="test"

src_prepare() {
	sed "/unpacked.dir/d" -i build.xml || die

	cd "${S}"/lib || die
	rm -v bsh-*.jar commons-codec-*.jar commons-lang-*.jar commons-net*.jar \
		l2fprod-common-tasks-7.3.jar skinlf-6.7.jar stax*.jar \
		jgoodies-form*.jar jgoodies-looks*.jar || die

	java-pkg_jar-from bsh,commons-codec,commons-lang-2.1,commons-net,jgoodies-forms,l2fprod-common,log4j,jgoodies-looks-2.0,skinlf,stax

	mkdir "${S}/public" || die "failed javadoc dir"
}

src_compile() {
	${ANT_OPTS} eant runtime-linux $(use_doc public-doc)
}

src_test() {
	java-pkg-2_src_test
}

src_install() {
	use source && java-pkg_dosrc src
	use doc && java-pkg_dojavadoc doc

	cd runtime/${PN}_linux || die

	java-pkg_dojar ${PN}.jar
	java-pkg_dojar "${S}"/lib/{htmlparser-1.6.jar,jRegistryKey-1.4.5.jar,jgoodies-common-1.2.1.jar,opencsv-2.3.jar,substance-6.1.jar,texhyphj-1.1.jar,trident-1.3.jar}

	local todir="${JAVA_PKG_SHAREPATH}"

	cp -a imgs "${D}/${todir}" || die
	cp -a icons "${D}/${todir}" || die
	cp -a plugins "${D}/${todir}" || die
	cp linux.properties "${D}/${todir}" || die

	insinto "${todir}/themepacks"
	doins themepacks/themepack.zip

	if use themes; then
		cd "${DISTDIR}"
		doins BeOSthemepack.zip\
			amarachthemepack.zip\
			aquathemepack.zip\
			architectBluethemepack.zip\
			architectOlivethemepack.zip\
			b0sumiErgothempack.zip\
			b0sumithemepack.zip\
			bbjthemepack.zip\
			beigeazulthemepack.zip\
			beosthemepack.zip\
			blueMetalthemepack.zip\
			blueTurquesathemepack.zip\
			cellshadedthemepack.zip\
			chaNinja-Bluethemepack.zip\
			coronaHthemepack.zip\
			cougarthemepack.zip\
			crystal2themepack.zip\
			fatalEthemepack.zip\
			gfxOasisthemepack.zip\
			gorillathemepack.zip\
			hmmXPBluethemepack.zip\
			hmmXPMonoBluethemepack.zip\
			iBarthemepack.zip\
			macosthemepack.zip\
			midnightthemepack.zip\
			mmMagra-Xthemepack.zip\
			modernthemepack.zip\
			oliveGreenLunaXPthemepack.zip\
			opusLunaSilverthemepack.zip\
			opusOSBluethemepack.zip\
			opusOSDeepthemepack.zip\
			opusOSOlivethemepack.zip\
			quickSilverRthemepack.zip\
			roueBluethemepack.zip\
			roueBrownthemepack.zip\
			roueGreenthemepack.zip\
			royalInspiratthemepack.zip\
			silverLunaXPthemepack.zip\
			solunaRthemepack.zip\
			tigerGraphitethemepack.zip\
			tigerthemepack.zip\
			toxicthemepack.zip\
			underlingthemepack.zip\
			whistlerthemepack.zip\
			xplunathemepack.zip
		insinto "${todir}/icons"
		doins noia.zip nuvola.zip tulliana.zip tango_without_heart.zip
	fi

	java-pkg_dolauncher "tvbrowser" \
		--main tvbrowser.TVBrowser \
		--pwd ${todir} \
		--java_args " -Dpropertiesfile=${todir}/linux.properties"

	make_desktop_entry ${PN} "TV-Browser" /usr/share/tvbrowser/imgs/tvbrowser128.png

	sed -e "s/AudioVideo;TV/AudioVideo;TV;Video/" \
		-i "${D}"/usr/share/applications/tvbrowser-tvbrowser.desktop || die "fixing .desktop file failed"
}
