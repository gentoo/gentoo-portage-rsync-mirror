# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/triplea/triplea-0.9.0.2-r1.ebuild,v 1.5 2008/01/10 23:14:02 caster Exp $

inherit eutils java-pkg-2 java-ant-2 versionator games

MY_PV=$(replace_all_version_separators _)
DESCRIPTION="An open source clone of the popular Axis and Allies boardgame"
HOMEPAGE="http://triplea.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${MY_PV}_source_code_only.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="=dev-java/jgoodies-looks-2*
	=dev-java/commons-httpclient-3*
	dev-java/commons-logging
	dev-java/commons-codec
	=dev-java/junit-3.8*"
DEPEND="${RDEPEND}
	>=virtual/jdk-1.5
	app-arch/unzip"
RDEPEND="${RDEPEND}
	>=virtual/jre-1.5"

S=${WORKDIR}/${PN}_${MY_PV}

pkg_setup() {
	games_pkg_setup
	java-pkg-2_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e 's/getWindows/getMyWindows/' \
		src/games/strategy/debug/Console.java \
		|| die "sed Console.java failed"

	sed -i \
		-e 's:/triplea/:/.triplea/:' \
		src/games/strategy/engine/framework/ui/SaveGameFileChooser.java \
		|| die "sed SaveGameFileChooser.java failed"

	rm -f lib/{junit.jar,derby_10_1_2.jar}
	java-pkg_jar-from jgoodies-looks-2.0 looks.jar lib/looks-2.0.4.jar
	java-pkg_jar-from commons-httpclient-3 commons-httpclient.jar \
		lib/commons-httpclient-3.0.1.jar
	java-pkg_jar-from commons-logging commons-logging.jar \
		lib/commons-logging-1.1.jar
	java-pkg_jar-from commons-codec commons-codec.jar \
		lib/commons-codec-1.3.jar
	# installs the test files
	java-pkg_jar-from --into lib junit
	java-pkg_ensure-no-bundled-jars
}

src_compile() {
	eant || die
	echo "triplea.saveGamesInHomeDir=true" > classes/triplea.properties
	# The only target creating this is zip which does unjar etc
	mkdir bin
	cd classes
	jar cf ../bin/triplea.jar * || die
	rm -fr * || die
}

# Needs X11 maybe use virtualx.eclass
RESTRICT="test"
src_test() {
	ANT_TASKS="ant-junit" eant test
}

src_install() {
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r bin data games images maps || die "doins failed"

	java-pkg_regjar "${D}/${GAMES_DATADIR}"/${PN}/bin/*.jar
	# TODO: add server launcher (see run-server.sh)
	java-pkg_dolauncher ${PN} -into "${GAMES_PREFIX}" --main \
		games.strategy.engine.framework.GameRunner

	newicon icons/triplea_icon.bmp ${PN}.bmp
	make_desktop_entry ${PN} TripleA /usr/share/pixmaps/${PN}.bmp

	dodoc changelog.txt || die
	dohtml -r doc/* readme.html || die
	prepgamesdirs
}
